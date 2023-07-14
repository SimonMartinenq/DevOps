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
      name: "Front_Image_Name",
      defaultValue: 'productivity-app-front',
      description: '')
    string(
      name: "Back_Image_Name",
      defaultValue: 'productivity-app-server',
      description: '')
    string(
      name: "Image_Tag",
      defaultValue: 'latest',
      description: 'Image tag')
  }

  environment {
    MONGODB_URI = credentials('mongodb-uri')
    TOKEN_KEY = credentials('token-key')
    EMAIL = credentials('email')
    PASSWORD = credentials('password')
  }

  stages {
    // stage('Frontend Tests') {
    //   steps {
    //     dir('client') {
    //       sh 'npm install'
    //       sh 'npm test'
    //     }
    //   }
    // }

    // stage('Backend Tests') {
    //   steps {
    //     dir('server') {
    //       sh 'npm install'
    //       sh 'export MONGODB_URI=$MONGODB_URI'
    //       sh 'export TOKEN_KEY=$TOKEN_KEY'
    //       sh 'export EMAIL=$EMAIL'
    //       sh 'export PASSWORD=$PASSWORD'
    //       sh 'npm test'
    //     }
    //   }
    // }

    stage('Build client app docker image') {
      steps {
        dir('client') {
			script {
				// def buildArgs = "."
				docker.build(
					"${params.Front_Image_Name}:${params.Image_Tag}")
				}
		}
      }
    }

    stage('Push client app docker image to dockerhub') {
      steps {
        dir('client') {
			script {
				def localImage = "${params.Front_Image_Name}:${params.Image_Tag}"
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

    stage('Build server docker image') {
      steps {
        dir('server') {
			script {
				// def buildArgs = "."
				docker.build(
					"${params.Back_Image_Name}:${params.Image_Tag}")
				}
		}
      }
    }
    
    stage('Push server docker image to dockerhub') {
      steps {
        dir('server') {
			script {
				def localImage = "${params.Back_Image_Name}:${params.Image_Tag}"
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