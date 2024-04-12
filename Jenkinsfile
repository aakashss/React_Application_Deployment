pipeline {
  agent any
  
  options {
    disableConcurrentBuilds()
  }
  
  stages {
    stage('git logic') {
      steps { 
        sh './git.sh'
      }
    }
  }  
}
