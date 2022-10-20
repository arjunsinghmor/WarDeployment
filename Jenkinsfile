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
		 sh '''#!/bin/bash
		 read -p "Enter Build Number:" Build
		 cd /home/ec2-user/
		 rm -rf *.war
		 wget http://vitrayabucket.s3.amazonaws.com/jobs/DeployS3Pipeline/$Build/target/wwp-1.0.0.war
		 cd /opt/tomcat/*/bin/ ./catalina.sh stop
		 cp -rf /home/ec2-user/*.war /opt/tomcat/*/webapps/
		 cd /opt/tomcat/*/bin/ ./catalina.sh start
		 echo "Version" $Build "deployed successfully"
                 '''
            }
        }
    }
}
