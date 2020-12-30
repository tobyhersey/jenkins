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

    stage('s3 ls') {
      steps {
        sh 'aws s3 ls'
      }
    }

    stage('terraform') {
      steps {
        sh 'terraform -v'
      }
    }

  }
}