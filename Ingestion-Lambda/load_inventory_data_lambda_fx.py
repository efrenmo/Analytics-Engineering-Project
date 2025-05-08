import os
import requests
import snowflake.connector as sf
from dotenv import load_dotenv

def lambda_handler(event, context):
    """
    AWS Lambda function that downloads inventory data from an S3 URL and loads it into Snowflake.
    
    This function performs an ETL process with the following steps:
    1. Downloads a CSV file from a specified S3 URL
    2. Saves the file to Lambda's temporary storage
    3. Establishes a connection to Snowflake using environment variables
    4. Creates or replaces a CSV file format definition in Snowflake
    5. Creates or replaces a stage in Snowflake for file storage
    6. Uploads the CSV file to the Snowflake stage
    7. Truncates the target table to prepare for fresh data
    8. Copies data from the staged file into the Snowflake table
    
    Parameters:
    -----------
    event : dict
        The event dict containing the parameters passed when the function is invoked
        (not used in this implementation but required by AWS Lambda)
    
    context : object
        The context object provided by AWS Lambda containing runtime information
        (not used in this implementation but required by AWS Lambda)
    
    Environment Variables:
    ---------------------
    user : str
        Snowflake username
    password : str
        Snowflake password
    account : str
        Snowflake account identifier
    warehouse : str
        Snowflake warehouse to use
    database : str
        Snowflake database to use
    schema : str
        Snowflake schema to use
    table : str
        Target Snowflake table for data loading
    role : str
        Snowflake role to use
    stage_name : str
        Name of the Snowflake stage to create/use
    
    Returns:
    --------
    dict
        Response containing status code and message:
        - Success: {'statusCode': 200, 'body': 'Success message'}
        - Error: {'statusCode': 400/500, 'body': 'Error message'}
    
    Raises:
    -------
    Exception
        Any exceptions are caught and returned as part of the response
    """
    try:
        # Request Parameters
        url='https://de-materials-tpcds.s3.ca-central-1.amazonaws.com/inventory.csv'
        destination_folder='/tmp'
        file_name='inventory.csv'
        local_file_path=f'{destination_folder}/{file_name}'

        # Load Snowflake Connection Parameters
        load_dotenv()

        # Verify Snowflake Connection Parameters
        required_vars = ['user', 'password', 'account', 'warehouse', 'database', 
                         'schema', 'table', 'role', 'stage_name']

        config = {}
        for var in required_vars:
            value = os.getenv(var)
            if not value:
                return {
                    'statusCode': 400,
                    'body': f'Missing required environment variable: {var}'
                }
            config[var] = value

        # Download the inventory file
        response = requests.get(url)
        response.raise_for_status()

        # Save to lambda's /tmp directory
        with open(local_file_path, 'wb') as file:
            file.write(response.content)
        
        with open(local_file_path, 'r') as file:
            file_content = file.read()
            print('File content preview:')
            print(
                file_content[:500] + '...' if len(file_content) > 500 else file_content
            )
        
        # Connect to Snowflake
        conn=None
        cursor=None
        try:
            conn = sf.connect(
                user=config['user'], 
                password=config['password'],
                account=config['account'], 
                warehouse=config['warehouse'],
                database=config['database'], 
                schema=config['schema'], 
                role=config['role']
            )
            cursor = conn.cursor()

            # Execute Snowflake operations
            cursor.execute(f"USE SCHEMA {config['schema']}")
            # Creates (or replaces if it already exists) a file format named "COMMA_CSV"
            # Specifies that this format is for CSV files (TYPE='CSV')
            # Defines that the delimiter between fields is a comma (FIELD_DELIMITER=',')
            cursor.execute("CREATE OR REPLACE FILE FORMAT COMMA_CSV TYPE='CSV' FIELD_DELIMITER=','")
            cursor.execute(f"CREATE OR REPLACE STAGE {config['stage_name']} FILE_FORMAT=COMMA_CSV")
            cursor.execute(f"PUT 'file://{local_file_path}' @{config['stage_name']}")
            cursor.execute(f"TRUNCATE TABLE {config['schema']}.{config['table']}")
            cursor.execute(f"COPY INTO {config['schema']}.{config['table']} FROM @{config['stage_name']}/{file_name} ON_ERROR=CONTINUE, FILE_FORMAT=COMMA_CSV") 

            return {
                'statusCode': 200,
                'body': 'File downloaded and uploaded to Snowflake successfully.'
            }
        
        finally:
            # Clean up resources
            if cursor:
                cursor.close()
            if conn:
                conn.close()
    except Exception as e:
        return {
            'statusCode': 500,
            'body': f'Error: {str(e)}'
        }