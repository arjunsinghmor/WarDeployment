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
                s3Upload consoleLogLevel: 'INFO', dontSetBuildResultOnFailure: false, dontWaitForConcurrentBuildCompletion: false, entries: [[bucket: 'vitrayapipeline', excludedFile: '/target', flatten: false, gzipFiles: false, keepForever: false, managedArtifacts: true, noUploadOnFailure: true, selectedRegion: 'us-west-2', showDirectlyInBrowser: false, sourceFile: '**/target/*.war', storageClass: 'STANDARD', uploadFromSlave: false, useServerSideEncryption: false]], pluginFailureResultConstraint: 'FAILURE', profileName: 'vitrayapipeline', userMetadata: []
            }
        }
	stage('Deploy') {
            steps {
               sh 'read -p "Enter Build Number:" Build'
               sh 'cd /home/ec2-user/'
               sh 'rm -rf *.war'
  	       sh 'wget https://vitrayapipeline.s3.us-west-2.amazonaws.com/jobs/S3BucketTesting/$Build/target/wwp-1.0.0.war'
	       sh 'cd /opt/tomcat/*/bin/ ./shutdown.sh'
               sh 'cp -rf /home/ec2-user/*.war /opt/tomcat/*/webapps/'
               sh 'cd /opt/tomcat/*/bin/ ./startup.sh'
               sh 'echo "Version" $Build "deployed successfully"'
            }
        }
    }
}
