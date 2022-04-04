pipeline {
  agent any

  environment {
    def GIT_URL = "https://github.com/UpperLeaf/jenkins-docker-runimage.git"
    def BUILD_VERSION = sh(script: "echo `date +%Y%m%d%H%M%S`", returnStdout: true).trim()
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
        dir('demo-project') {
          script {
            app = docker.build('leafupper/demo-project')
          }
        }
      }
    }

    stage('test image') {
      steps {
        dir('demo-project') {
          script {
            app.withRun('-p 8081:8080') { c ->
              sh "echo hostIP : ${hostIp(c)}"
              sh KARATE_TEST_CURL
            }
          }
        }
      }
    }

    stage('publish image') {
      steps {
        dir('demo-project') {
          script {
            app.push("leaf-${BUILD_VERSION}")
          }
        }
      }
    }
  }
}

def hostIp(container) {
  sh "docker inspect -f {{.Node.Ip}} ${container.id} > hostIp"
  readFile('hostIp').trim()
}
