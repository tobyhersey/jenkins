pipeline {
    agent {
        docker { image 'linuxacademycontent/jenkins_pipelines' }
    }
    stages {
        stage('fetch') {
            steps {
                sh 'git clone https://github.com/linuxacademy/content-pipelines-cje-labs.git'
            }
        }
        stage('build'){
            steps{
                sh 'gcc --std=c99 -o mario content-pipelines-cje-labs/lab1_lab2/mario.c'
            }
        }
        stage('archive'){
            steps{
                archiveArtifacts artifacts: 'mario'
            }
        }
    }
}
