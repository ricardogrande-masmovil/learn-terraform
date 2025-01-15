import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    logger.info('Processing SQS messages')
    
    for record in event['Records']:
        try:
            # Parse the message body
            message = json.loads(record['body'])
            logger.info(f'Processing message: {message}')
            
            # TODO: Add your processing logic here
            
        except Exception as e:
            logger.error(f'Error processing message: {str(e)}')
            # Don't raise the exception - let Lambda delete the message from the queue
            continue
    
    return {
        'statusCode': 200,
        'body': json.dumps('Processing complete')
    } 