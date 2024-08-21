1. EC2 Instance
        Jenkins: Installed on the EC2 instance, accessible via http://<public-ip>:8080.
        Docker: Used to build, tag, and deploy the application.
        Nginx: Acts as a web server for the deployed application.
2. GitHub Repository
        Dockerfile: Defines the Docker image used to containerize the application.
        build.sh: Script used to build, tag, and push the Docker image to the Docker repository.
        deploy.sh: Script used to pull the Docker image from the Docker repository and deploy it to the Docker container.
        Jenkinsfile: Defines the Jenkins pipeline, which triggers builds and deployments based on the branch (dev or master).
3. Jenkins Pipeline
        Branch-Based Deployment:
        Code committed to the dev branch triggers a build and pushes the Docker image to the development Docker repository.
        Code committed to the master branch triggers a build and pushes the Docker image to the production Docker repository.
        Deployment: After the Docker image is pushed to the respective repository, the application is deployed to the EC2 instance using deploy.sh.
4. Route 53 Monitoring
        Health Checks: Configured to monitor the React application hosted on the EC2 instance.
        Notifications: Email notifications are triggered if the application is unreachable.

**Setup**

1. Prerequisites
        An AWS EC2 instance with Jenkins, Docker, and Nginx installed.
        A GitHub repository containing the necessary build and deployment files (Dockerfile, build.sh, deploy.sh, Jenkinsfile).
        Access to Docker Hub or another Docker repository for storing images.
        AWS Route 53 configured for monitoring.
2. Jenkins Configuration
        Set up a Jenkins job with the following configurations:
        Source Code Management: Connect to the GitHub repository.
        Build Triggers: Enable "Poll SCM" or use GitHub webhooks to trigger builds automatically.
        Pipeline: Use the Jenkinsfile from the repository to define the build and deployment process.
3. Deployment Process
        When code is committed to the dev branch, Jenkins will:
        Run build.sh to build, tag, and push the Docker image to the development repository.
        Run deploy.sh to deploy the Docker image to the EC2 instance.
        When code is committed to the master branch, Jenkins will:
        Run build.sh to build, tag, and push the Docker image to the production repository.
        Run deploy.sh to deploy the Docker image to the EC2 instance.
4. Application Access
        The application will be accessible at http://<public-ip-of-the-instance>.
5. Monitoring
        Route 53 will monitor the health of the application. If the application goes down, an email notification will be sent to the configured email address.
