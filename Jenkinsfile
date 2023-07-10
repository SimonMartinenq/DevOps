pipeline {
    
    agent { 
    label 'docker-slave' 
    
}
    
    environment {
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
    }
}