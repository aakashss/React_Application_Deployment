pipeline {
  agent any
  
  triggers {
    scm {
      branch('*/***dev')
    }
  }
  options {
    disableConcurrentBuilds()
  }
  
  stages {
    stage('Checkout Code') {
      steps {
        git branch: "${env.BRANCH_NAME}", credentialsId: 'aakashss', url: 'https://github.com/aakashss/project.git'	      
      }
  }
    stage('Build Docker Image dev') {
      when {
        expression { branch =~ /(.*)dev$/ }
      }
      steps {
        sh 'docker build -t aakashss/dev:${env.BRANCH_NAME} .'
      }
    }
    stage('Build Docker Image prod') {
      when {
        expression { branch =~ /(.*)prod$/ }
      }
      steps {
        sh 'docker build -t aakashss/dev:${env.BRANCH_NAME} .'
      }
    }
    stage('Push Docker Image (dev)') {
      when {
        expression { branch =~ /(.*)dev$/ }
      }
      steps {
        withCredentials([usernamePassword(credentialsId: 'aakashss', usernameVariable: 'aakashss', passwordVariable: 'M2RV(3Sy2Jd@EUJ')]) {
          sh "docker login -u $USERNAME -p $PASSWORD"
          sh "docker push your_username/dev:${env.BRANCH_NAME}"
        }
      }
    }
    stage('Push Docker Image prod') {
      when {
        expression { branch =~ /(.*)prod$/ }
      }
      steps {
        withCredentials([usernamePassword(credentialsId: 'aakashss', usernameVariable: 'aakashss', passwordVariable 'M2RV(3Sy2Jd@EUJ')]) {
        sh "docker login -u $USERNAME -p $PASSWORD"
        sh 'docker push aakashss/prod:latest'
        }
      }  
    }
  } 
} 
