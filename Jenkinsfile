pipeline {
  environment {
    imagename = "aredan/facilemanager-docker"
    registryCredential = 'dockerhub_id'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git([url: 'https://github.com/aredan/facilemanager-docker.git', branch: 'master'])

      }
    }
    stage('Building Image') {
      steps{
        script {
          dockerImage = docker.build imagename
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) 
        {
            dockerImage.push("$BUILD_TIMESTAMP")
            dockerImage.push('latest')
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps
      {
        // sh "docker rmi $imagename:$BUILD_TIMESTAMP"
        // sh "docker rmi $imagename:latest"
        sh "docker system prune -af --volumes"
 
      }
    }
  }
}
