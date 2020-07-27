pipeline{
agent {
  docker {
   image 'gnschenker/node-docker'
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
}
}