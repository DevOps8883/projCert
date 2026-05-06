pipeline {
    agent any
    stages {
        stage('Source') {
            steps {
                echo 'Pulling code from GitHub...'
                checkout scm
            }
        }
        stage('Provision') {
            steps {
                echo 'Running Ansible Playbook...'
                // This is where your Ansible command will go later
            }
        }
        stage('Build & Deploy') {
            steps {
                echo 'Building Docker Image...'
                // This is where your Docker commands will go later
            }
        }
    }
}  
