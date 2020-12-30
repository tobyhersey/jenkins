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

    stage('terraform apply') {
      steps {
        sh '''terraform init && \\
terraform plan && \\
terraform apply -auto-approve'''
      }
    }

    stage('manual b4 destory') {
      steps {
        input 'want to destroy?'
      }
    }

  }
}