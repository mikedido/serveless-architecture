import boto3
import json

def lambda_handler(event, context):
    
    session = boto3.session.Session(region_name='us-east-1')
    client = session.client('s3')
    resource = session.resource('s3')
    
    my_bucket = resource.Bucket('sacembucket')
    files = list(my_bucket.objects.filter(Prefix=''))
    payload = []
    
    for file in files:
        payload.append({"key": file.key})

    
    return {
        'statusCode': 200,
        'body': json.dumps(payload)
    }
