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
              deploy adapters: [tomcat9(credentialsId: '2b325638-8b5f-4705-b94c-c7c3ccd606ab', path: '', url: 'http://35.93.24.55:8080/')], contextPath: '/', onFailure: false, war: '**/target/*.war'
            }
        }
    }
}
