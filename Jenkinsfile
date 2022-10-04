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
                echo 'Build passed'
                echo 'Deploying war on Tomcat'
            }
        }
    }
}
