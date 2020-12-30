pipeline {
  agent {
    node {
      label 'worker'
    }

  }
  stages {
    stage('docker run') {
      steps {
        sh 'docker run --rm hello-world'
      }
    }

  }
}