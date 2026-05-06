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
               // This helper (ansiblePlaybook) handles the SSH keys for you
               ansiblePlaybook(
                   ansibleName: 'ansible-local', // Ensure this matches your Tool Name in Jenkins
                   playbook: 'setup-server.yml',
                   inventory: 'hosts.ini',
                   credentialsId: 'test-server-key' // The ID we created in Step 2
        )
    }
}

        stage('Build & Containerize') {
            steps {
                echo 'Step 3: Building Docker Image...'
                script {
                    // This uses the Dockerfile you just created
                    sh "docker build -t applebite-app ."
                }
            }
        }

        stage('Deploy to Test') {
            steps {
                echo 'Step 4: Deploying to Test Server...'
                script {
                    // This stops any old container and starts the new one
                    sh "docker rm -f applebite-test || true"
                    sh "docker run -d --name applebite-test -p 8081:80 applebite-app"
                }
            }
        }
    }
}
