pipeline {
  agent any

  environment {
    def GIT_URL = "https://github.com/UpperLeaf/jenkins-docker-runimage.git"
  }

  stages {
    stage ('checkout') {

      steps {
        dir('demo-project') {
          git branch : 'master', url : "${GIT_URL}"
        }
      }
    }

    stage('build') {
      steps {
        dir('demo-project') {
          sh './gradlew build'
        }
      }
    }

    stage('build image') {
      steps {
        app = docker.build('leafupper/demo-project:latest')
        app.push()
      }
    }
  }

}
