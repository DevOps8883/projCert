pipeline {
    agent any

    stages {
        stage('Source') {
            steps {
                echo 'Step 1: Pulling code from GitHub...'
                checkout scm
            }
        }

        stage('Provision Environment') {
            steps {
                echo 'Step 2: Running Ansible Playbook...'
                // Corrected: Added missing closing parenthesis/brace for the step
                ansiblePlaybook(
                    ansibleName: 'ansible-local', 
                    playbook: 'setup-server.yml',
                    inventory: 'hosts.ini',
                    credentialsId: 'test-server-key',
                     disableHostKeyChecking: true
                )
            }
        }

        stage('Build & Containerize') {
            steps {
                echo 'Step 3: Building Docker Image...'
                script {
                    sh "docker build -t applebite-app ."
                }
            }
        }

        stage('Deploy to Test') {
            steps {
                echo 'Step 4: Deploying to Test Server...'
                script {
                    sh "docker rm -f applebite-test || true"
                    sh "docker run -d --name applebite-test -p 8081:80 applebite-app"
                }
            }
        }
        
        stage('Deploy to Production') {
            steps {
                // The 'One-Click' requirement
                input message: 'Promote to Production?', ok: 'Deploy Now'
                
                echo 'Deploying to Production Server...'
                // Ensure the 'applebite-app' image exists on the prod server or is pulled from a registry
                sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.41.200 'docker rm -f applebite-prod || true && docker run -d --name applebite-prod -p 80:80 applebite-app'"
            }
        }  
    }
}
