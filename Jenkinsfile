pipeline {
  agent any
    tools {
        maven '3.6.3'
    }
    stages {
	stage('Checkout to agent') {
            steps {
               sh '''ssh root@34.212.20.94 
	       '''
            }
        }
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
              sh '''cd /opt/tools/
                    ./deploy.sh
                '''
            }
        }
    }
}
