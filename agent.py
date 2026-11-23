import boto3

def list_s3_objects(bucket_name): 
    
    List all objects in an S3 bucket.

    Args:
        bucket_name (str): The name of the S3 bucket

    s3_client = boto3.client("s3")

    try:
        response = s3_client.list_objects_v2(Bucket=bucket_name)
        
        if "Contents" in response:
            print (f"Objects in bucket {bucket_name}:':")
            for obj in response["Contents"]:
                print(f"  - {obj['Key']} (Size: {obj['Size']} bytes)")
        else:
            print(f"Bucket {bucket_name} is empty.")

    except Exception as e:
        print(f"Error listing objects: {e}")

if __name__ == "__main__":
    bucket_name = "your-bucket-name"  # Replace with your S3 bucket name
    list_s3_objects(bucket_name)
    
    
