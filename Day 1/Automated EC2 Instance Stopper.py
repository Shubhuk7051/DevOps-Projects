import boto3
from datetime import datetime, timedelta, timezone

def  lambda_handler(event,context):
    
    ec2=boto3.client('ec2')
    
    instance=ec2.describe_instances(
        Filters=[
            {'Name': 'tag:AutoStop', 'Values': ['true']},
            {'Name': 'instance-state-name', 'Values': ['running']}
        ]
    )
    
    current_time=datetime.now(timezone.utc)
    
    for reservation in instance['Reservations']:
        for instance in reservation['Instances']:
            instance_id=instance['InstanceId']
            launch_time=instance['LaunchTime']
            uptime=current_time-launch_time.replace(tzinfo=timezone.utc)  # Make launch_time offset-aware
            
            total_minutes = int(uptime.total_seconds() / 60)
            
            if uptime > timedelta(minutes=10): # If the instance has been running longer than 10 minutes, stop it

                print(f"Stopping Instance {instance_id} which has been running for {total_minutes} minutes")
                ec2.stop_instances(InstanceIds=[instance_id])
            
            elif uptime.days > 30:
                print(f"Terminating Instance {instance_id} which has been running for {uptime.days} days")
                ec2.terminate_instances(InstanceIds=[instance_id])
            
            else:
                print(f"Instance {instance_id} has been running for {total_minutes} minutes or {uptime.days} days, skipping termination")