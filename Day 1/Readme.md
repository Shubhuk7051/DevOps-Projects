Project: Automated EC2 Instance Stopper

Step 1: Set Up AWS Environment
Make sure you have an AWS account set up and configured with appropriate IAM permissions. 
You'll need permissions to create Lambda functions, as well as to interact with EC2 instances.

Step 2: Create IAM Role for Lambda
You need to create an IAM role with permissions for Lambda to interact with EC2 instances.
Attach the AmazonEC2ReadOnlyAccess policy to this role. 
This policy grants Lambda read-only access to EC2 instances.

Step 3: Write Lambda Function Code
Refer "Automated EC2 Instance Stopper.py" file

Explanation: 
1> Import the boto3 library, which is the AWS SDK for Python.
2> In the lambda_handler function, first create an EC2 client object using boto3.client('ec2').
3> Retrieves information about EC2 instances that are tagged with 'AutoStop' set to 'true' and are currently in the 'running' state.
4> Gets the current time in UTC timezone.
5> Iterates through the retrieved instances and Extracts the instance ID and launch time of each instance.
6> Calculates the uptime of the instance by subtracting the launch time from the current time. This makes sure both times are in UTC timezone.
7> Calculates the total uptime in minutes.
8> Checks if the instance has been running for more than 10 minutes. If so, stops the instance.
Checks if the instance has been running for more than 30 days. If so, terminates the instance.
If neither condition is met, prints the uptime and skips termination.

Step 4: Configure Lambda Function
Create a new Lambda function in the AWS Management Console.
Select the Python runtime.
Paste the code into the Lambda function editor.
Configure the Lambda function to use the IAM role created in Step 2 and add some policies according to the code.

For Testing the Project:
Manually start an EC2 instance with the 'AutoStop' tag set to 'true' and observe if it gets stopped automatically. 
