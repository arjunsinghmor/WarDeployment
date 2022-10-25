#!/bin/bash
read -p "Enter Build Number:" Build
cd /home/ec2-user/
rm -rf *.war
wget https://vitrayabucket.s3.us-west-2.amazonaws.com/jobs/S3BucketTesting/$Build/target/wwp-1.0.0.war
cd /opt/tomcat/*/bin/ ./shutdown.sh
cp -rf /home/ec2-user/*.war /opt/tomcat/*/webapps/
cd /opt/tomcat/*/bin/ ./startup.sh
echo "Version" $Build "deployed successfully"
