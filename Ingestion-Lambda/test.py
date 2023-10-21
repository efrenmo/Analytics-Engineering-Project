import os
import boto3
import requests
import snowflake.connector as sf
from dotenv import load_dotenv
import json
import os 
import snowflake.connector as sf


load_dotenv()  
user= os.getenv('user')
password= os.getenv('password')
account= os.getenv('account')
warehouse= os.getenv('warehouse')
database= os.getenv('database')
schema= os.getenv('schema')
table= os.getenv('table')
role= os.getenv('role')
stage_name= os.getenv('stage_name')

print(user)
print(password)
print(stage_name)