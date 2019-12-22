#!groovy

pipeline {
  agent any
  tools {
     maven "Maven"
     jdk "JDK"
  }

  stages {
    stage('Test') {
      steps {
        bat 'mvn test'
      }
    }
  }
}