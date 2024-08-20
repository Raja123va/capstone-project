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
                    // Fetch the branch name from the Git plugin or environment
                    def branchName = env.BRANCH_NAME ?: sh(script: 'git rev-parse --abbrev-ref HEAD', returnStdout: true).trim()
                   
                    if (branchName == '') {
                        error "Unable to determine the branch name."
                    }
                   
                    echo "Branch Name: ${branchName}"
                   
                    // Checkout the branch
                    checkout([$class: 'GitSCM',
                              branches: [[name: branchName]],
                              userRemoteConfigs: [[url: 'https://github.com/Raja123va/capstone-project.git']]])

                    // Debugging information
                    sh 'git status'
                    sh 'git branch'
                   
                    // Set branchName as an environment variable for use in other stages
                    env.BRANCH_NAME = branchName
                }
            }
        }
        stage('Run Build Script') {
            steps {
                script {
                    def branchName = env.BRANCH_NAME
                   
                    echo "Branch Name in Build Stage: ${branchName}"

                    // Handle different branches
                    if (branchName == 'dev') {
                        echo "Running build script for dev branch"
                        sh "sed -i 's/dev/dev/g' build.sh"
                    } else if (branchName == 'master') {
                        echo "Running build script for master branch"
                        sh "sed -i 's/dev/prod/g' build.sh"
                    } else {
                        echo "Branch ${branchName} is not explicitly handled in the build script."
                        // Optionally add a default behavior for other branches
                        sh "sed -i 's/dev/other/g' build.sh"
                    }
                    sh './build.sh'
                }
            }
        }
        stage('Run Deploy Script') {
            steps {
                script {
                    def branchName = env.BRANCH_NAME
                   
                    echo "Branch Name in Deploy Stage: ${branchName}"
                   
                    if (branchName == 'dev') {
                        echo "Running deploy script for dev branch"
                        sh "sed -i 's/dev/dev/g' deploy.sh"
                    } else if (branchName == 'master') {
                        echo "Running deploy script for master branch"
                        sh "sed -i 's/dev/prod/g' deploy.sh"
                    } else {
                        echo "Branch ${branchName} is not explicitly handled in the deploy script."
                        // Optionally add a default behavior for other branches
                        sh "sed -i 's/dev/other/g' deploy.sh"
                    }
                    sh './deploy.sh'
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
        failure {
            echo 'Pipeline failed. Reviewing logs for errors...'
            // Add any additional steps for failure handling if needed
        }
        success {
            echo 'Pipeline succeeded.'
            // Add any additional steps for success handling if needed
        }
    }
}
