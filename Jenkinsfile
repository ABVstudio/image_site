pipeline {
    agent {
         node {
          label 'udh-1'
       }
    }
    
    environment {
        Name_image   = 'image_site'
        URL_image    = 'git@github.com:ABVstudio/image_site.git'
        ECR_build    = "443370672158.dkr.ecr.us-east-1.amazonaws.com/lepsey_repository:latest"
    }

    stages {
        stage('clear') {
            steps {
                sh ' if [ "$(sudo docker ps -aq)" != "" ]; then sudo docker rm -f $(sudo docker ps -aq); fi'
            }
        }
        stage('download') {
            steps {
                sh "if [ -d ${Name_image} ]; then cd ${Name_image} && git pull ;else git clone ${URL_image}; fi"
            }
        }
        stage('crate build') {
            steps {
                sh "cd ${Name_image}"
                sh "sudo docker build -t ${Name_image} ${Name_image}"
                //sh 'sleep 20s'
            }
        }
        stage('login aws') {
            steps {
                sh 'aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 443370672158.dkr.ecr.us-east-1.amazonaws.com'
            }
        }
        stage('aws tag and push') {
            steps {
                sh "sudo docker tag ${Name_image}:latest ${ECR_build}"
                sh "sudo docker push ${ECR_build}"
            }
        }
        stage('clear image') {
            steps {
                sh "sudo docker system prune -a"
            }
        }
    }
}
