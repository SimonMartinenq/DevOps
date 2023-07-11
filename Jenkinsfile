pipeline {
  agent {
    label 'docker-slave'

  }
  parameters {
    string(
      name: "Branch_Name",
      defaultValue: 'master',
      description: '')
    string(
      name: "Image_Name",
      defaultValue: 'clientapp',
      description: '')
    string(
      name: "Image_Tag",
      defaultValue: 'latest',
      description: 'Image tag')
  }

  environment {
	PATH = "/usr/bin/docker"
    MONGODB_URI = credentials('mongodb-uri')
    TOKEN_KEY = credentials('token-key')
    EMAIL = credentials('email')
    PASSWORD = credentials('password')
  }

  stages {
    stage('Frontend Tests') {
      steps {
        dir('client') {
          sh 'npm install'
          sh 'npm test'
        }
      }
    }

    stage('Backend Tests') {
      steps {
        dir('server') {
          sh 'npm install'
          sh 'export MONGODB_URI=$MONGODB_URI'
          sh 'export TOKEN_KEY=$TOKEN_KEY'
          sh 'export EMAIL=$EMAIL'
          sh 'export PASSWORD=$PASSWORD'
          sh 'npm test'
        }
      }
    }

    stage('Build client app docker image') {
      steps {
        dir('client') {
			script {
				def buildArgs = "'-f Dockerfile .'"
				docker.build(
					"${params.Image_Name}:${params.Image_Tag}",
					buildArgs)
				}
		}
      }
    }

    stage('Push client app docker image to dockerhub') {
      steps {
        dir('client') {
			script {
				def localImage = "${params.Image_Name}:${params.Image_Tag}"
				def repositoryName = "pierre15602/${localImage}"

				sh "docker tag ${localImage} ${repositoryName} "
				docker.withRegistry("", "DockerHubCredentials") {
					def image = docker.image("${repositoryName}");
					image.push()
				}
			}
        }
      }
    }
  }
}