pipeline{
environment {
        registry = "tmuhader/weather-at"
        DOCKER_PWD = credentials('docker-login-pwd')
    }
agent {
  docker {
  //this image is used for the Docker agent for the Build and Test stages
   image 'node:14.2.0-alpine'
               args '-p 3000:3000'
               args '-w /app'
               args '-v /var/run/docker.sock:/var/run/docker.sock'
   }
}
options {
        skipStagesAfterUnstable()
}

stages{
    stage("Build"){
        steps{
            sh 'npm install'
        }
    }
    stage("Test"){
        steps{
            echo '*****Unit Test to be added****'
        }
    }
    stage("Build image & push it to DockerHub"){
        steps{
            sh 'docker image build -t $registry:$BUILD_NUMBER .'
            sh 'docker login -u tmuhader -p $DOCKER_PWD'
            sh 'docker image push $registry:$BUILD_NUMBER'
            sh 'docker image rm $registry:$BUILD_NUMBER'
        }
    }
}
}