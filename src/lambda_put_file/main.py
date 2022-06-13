import boto3
import base64
import json

def lambda_handler(event, context):
    
    file_name = event['headers']['file-name']
    file_content = base64.b64decode(event['body'])
    
    session = boto3.session.Session(region_name='us-east-1')
    client = session.client('s3')
    resources = session.resource('s3')
    
    try:
        
        client.put_object(Bucket='sacem-bucket', Key=file_name, Body=file_content)
        
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
            },
            'body': 'Your file has been upload succefully'
        }
    except Exception as e:
        raise e
