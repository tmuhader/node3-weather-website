pipeline{
//We will be using those variables in the Build & Push Docker image stage:
environment {
//fully qualified name, which looks as follows: <registry URL>/<User or Org>/<image name>:<tag>
        registry = "tmuhader/weather-at"
        //we created a credentials in Jenkins in the menu:
        //  Jennkins->Manage Jenkins->Manage Credentials
        DOCKER_PWD = credentials('docker-login-pwd')
    }
agent {
/*
this is a permanent Docker agent configuration where the build is run into a container created by permanent general-purpose agent
but the agent itself is not running inside a container(though in our case we are running also Jenkins master from a container)
see page 92 in Jenkins book. this configuration is different from the dynamically provisioned Docker agent configured using Docker Cloud after installing Docker plugin.
docker: Execute the Pipeline, or stage, with the given container which will be dynamically provisioned on a node pre-configured (as permanent agent node )
to accept Docker-based Pipelines, or on a node matching the optionally defined label parameter (label can be set in the Pipeline matching a agent node label)
*/
  docker {
  //this image is used for the Docker agent for all the pipeline stages.  it must contain NodeJS to execute npm install command
  //(from Build stage) and Docker CLI to execute Docker commands (from Build image & push it to DockerHub). Alternatively, we can create
  //our image (based on Node and we add Docker CLI) as we did in the Builder-container example
   image 'matthewhartstonge/node-docker'
               args '-p 3000:3000'
               //this is useless here
               args '-w /app'
               /*
               The Docker CLI uses a socket to communicate with the Docker Engine; it is often called the Docker
               #socket. If we can give access to the Docker socket to an application running inside a container then we can just install
               #the Docker CLI inside this container, and we will then be able to run an application in the same container that uses this
               #locally installed Docker CLI to automate container-specific tasks. so this command will allow the Agent container to execute Docker commands
               using the Docker server in the host machine
               */
               args '-v /var/run/docker.sock:/var/run/docker.sock'
   }
}
options {
        skipStagesAfterUnstable()
}

stages{
//command git url was not invoked here as in the Jenkins book, but the application code is being copied when the Jenkins
//fetch the Jenkinsfile from Github
    stage("Build"){
    notify("Build started")
        steps{
            sh 'npm install'
        }
    }
    stage("Test"){
        steps{
            echo '*****Unit Test to be added****'
        }
    }
    /*
    once the application is built, unit-tested on the Jenkins agent, we can create an image (package) and push it to Dockerhub
    to be used for AT (this is the simple CI pipeline/ Commit phase of the CD flow)
    */
    stage("Build image & push it to DockerHub"){
        steps{
        /*
        The most generic way to define an image is by its fully qualified name, which looks as follows: <registry URL>/<User or Org>/<name>:<tag>
        see Location 2168

        this image is used by the api container to run our application (weather API) to receive requests from testing container
        for Acceptance Testing stage. this image is different than the image used earlier for Jenkins agent "matthewhartstonge/node-docker".
        we need to create 2 Dockerfiles, one for the agent image and one for the AT container image (or we can use Environment variables at build time).
        The AT image is built using the Dockerfile which was copied by the Jenkins agent when it fetched the Jenkinsfile and other code from Github

        $BUILD_NUMBER is an Env variable defined by Jenkins (http://localhost:8080/env-vars.html/)
        */
        echo '*****Build image to be added****'
//             sh 'docker image build -t $registry:$BUILD_NUMBER .'
//             sh 'docker login -u tmuhader -p $DOCKER_PWD'
//             sh 'docker image push $registry:$BUILD_NUMBER'
//             sh 'docker image rm $registry:$BUILD_NUMBER'
        }
    }
    /*
    this stage will execute the following:
    1)
    */
    stage("Deploy and integration test"){
        steps{
            echo "script to be added"
        }
    }
   /* stage("cleaning"){
        steps{
            cleanWs()
        }
    }*/
}

def notify(status){
    emailext (
      to: "tmuhader@gmail.com",
      subject: "${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """<p>${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></p>""",
    )
}
}