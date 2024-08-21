EC2 instance :
  installed with jenkins (public ip with port 8080), docker, nginx

Github :
  Github has all the build and deploy files.
  Dockerfile and build.sh - used to build, tag and push the image to docker repo
  deploy.sh - used to pull the docker image from docker repo and deploy it to the docker container.

  application will be accessible with http://<public-ip-of-the-instance/ec2>

  Jenkins: 
    we have a jenkinsfile in githup repo which will push run the deployment process and push the docker image to dev docker repo if code is commited in dev or it will push the docker image to prod docker repo and deploy accordingly.

  Application monitoring:
    Route53 is used to monitor the react application.If the site is down it will trigger the mail.
