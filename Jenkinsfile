pipeline {
    agent any
    environment {
        DEV_REPO = 'raja123va/dev-repo'
        PROD_REPO = 'raja123va/prod-repo'
        DOCKER_CREDENTIALS_ID = 'capstone-dockerhub1'
    }
    stages {
        stage('Checkout') {
            steps {
                script {
                  checkout([$class: 'GitSCM', 
                              branches: [[name: '*/${env.BRANCH_NAME}']],
                              userRemoteConfigs: [[url: 'https://github.com/Raja123va/capstone-project.git']]])
                    
                    // Capture the branch name from the environment
                    def branchName = env.BRANCH_NAME
                    echo "Branch Name: ${branchName}"
                }
            }
        }
        stage('Run Build Script') {
            steps {
                script {
                    def branchName = sh(script: 'git rev-parse --abbrev-ref HEAD', returnStdout: true).trim()
                   
                    if (branchName == 'dev') {
                        echo "Running build script for dev branch"
                        sh "sed -i 's/${dev}/dev/g' build.sh"
                        sh './build.sh'
                    } else if (branchName == 'master') {
                        echo "Running build script for master branch"
                        sh "sed -i 's/${dev}/prod/g' build.sh"
                        sh './build.sh'
                    } else {
                        error "Branch ${branchName} is not supported for builds!"
                    }
                }
            }
        }
        stage('Run Deploy Script') {
            steps {
                script {
                    def branchName = sh(script: 'git rev-parse --abbrev-ref HEAD', returnStdout: true).trim()
                   
                    if (branchName == 'dev') {
                        echo "Running deploy script for dev branch"
                        sh "sed -i 's/${dev}/dev/g' deploy.sh"
                        sh './deploy.sh'
                    } else if (branchName == 'master') {
                        echo "Running deploy script for master branch"
                        sh "sed -i 's/${dev}/prod/g' deploy.sh"
                        sh './deploy.sh'
                    } else {
                        error "Branch ${branchName} is not supported for deployment!"
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
