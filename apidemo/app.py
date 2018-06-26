import json
import requests

def lambda_handler(event, context):
    """Sample pure Lambda function

    Arguments:
        event LambdaEvent -- Lambda Event received from Invoke API
        context LambdaContext -- Lambda Context runtime methods and attributes

    Returns:
        dict -- {'statusCode': int, 'body': dict}
    """

    if event['path'] == '/':
        return {
            "statusCode": 200,
            "body": json.dumps({
                'message': '1.1.1.9',
            })
        }
    else:
        ip = requests.get('http://checkip.amazonaws.com/')
        return {
            "statusCode": 200,
            "body": json.dumps({
                'message': ip.text.replace('\n', ''),
            })
        }
