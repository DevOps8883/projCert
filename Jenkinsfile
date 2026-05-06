pipeline {
    agent any 

    options {
        // This prevents the build from disappearing by forcing Jenkins to keep the last 10 records
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

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
                ansiblePlaybook(
                    installation: 'ansible-local', 
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
                
                echo 'Step 5: Deploying to Production Server...'
                // Using withCredentials since sshagent plugin is missing
                withCredentials([sshUserPrivateKey(credentialsId: 'test-server-key', keyFileVariable: 'SSH_KEY')]) {
                    sh "ssh -i ${SSH_KEY} -o StrictHostKeyChecking=no ubuntu@172.31.41.200 'sudo docker rm -f applebite-prod || true && sudo docker run -d --name applebite-prod -p 80:80 applebite-app'"
                }
            }
        }  
    }
}
