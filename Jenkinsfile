pipeline {
    agent any 

    options {
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
                    sh 'docker build -t applebite-app .'
                }
            }
        }

        stage('Deploy to Test') {
            steps {
                echo 'Step 4: Deploying to Test Server...'
                script {
                    sh 'docker rm -f applebite-test || true'
                    sh 'docker run -d --name applebite-test -p 8081:80 applebite-app'
                }
            }
        }
        
        stage('Deploy to Production') {
            steps {
                input message: 'Promote to Production?', ok: 'Deploy Now'
                
                echo 'Step 5: Transferring Image and Deploying to Production...'
                withCredentials([sshUserPrivateKey(credentialsId: 'test-server-key', keyFileVariable: 'SSH_KEY')]) {
                    script {
                        // 1. Export the image from the Jenkins build node
                        sh 'docker save applebite-app > applebite-app.tar'
                        
                        // 2. Transfer the image to the Production server
                        sh 'scp -i ${SSH_KEY} -o StrictHostKeyChecking=no applebite-app.tar ubuntu@172.31.41.200:/tmp/'
                        
                        // 3. Load image on Prod server, clean up old container, and start new one
                        sh '''
                            ssh -i ${SSH_KEY} -o StrictHostKeyChecking=no ubuntu@172.31.41.200 "
                                sudo docker load < /tmp/applebite-app.tar && \
                                sudo docker rm -f applebite-prod || true && \
                                sudo docker run -d --name applebite-prod -p 80:80 applebite-app
                            "
                        '''
                        
                        // 4. Local cleanup of the tar file
                        sh 'rm applebite-app.tar'
                    }
                }
            }
        }  
    }
}
