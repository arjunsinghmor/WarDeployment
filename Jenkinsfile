pipeline {
  agent any
    tools {
        maven '3.6.3'
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Publish') {
            steps {
                s3Upload consoleLogLevel: 'INFO', dontSetBuildResultOnFailure: false, dontWaitForConcurrentBuildCompletion: false, entries: [[bucket: 'vitrayabucket', excludedFile: '/target', flatten: false, gzipFiles: false, keepForever: false, managedArtifacts: true, noUploadOnFailure: true, selectedRegion: 'us-west-2', showDirectlyInBrowser: false, sourceFile: '**/target/*.war', storageClass: 'STANDARD', uploadFromSlave: false, useServerSideEncryption: false]], pluginFailureResultConstraint: 'FAILURE', profileName: 'vitrayabucket', userMetadata: []
            }
        }
	stage('Deploy') {
            steps {
		 sh '''sudo su -
		 cd /home/ec2-user/
		 rm -rf *.war
		 wget https://vitrayapipeline.s3.us-west-2.amazonaws.com/jobs/S3BucketTesting/$Build/target/wwp-1.0.0.war
		 cd /opt/tomcat/*/bin/ ./shutdown.sh
		 cp -rf /home/ec2-user/*.war /opt/tomcat/*/webapps/
		 cd /opt/tomcat/*/bin/ ./startup.sh
		 echo "Version" $Build "deployed successfully"'''
            }
        }
    }
}
