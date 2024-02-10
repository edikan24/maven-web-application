```docker
pipeline {
    agent any

    environment {
        SONARQUBE_HOST = 'sonarqube'
        SONARQUBE_PORT = '9000'
        NEXUS_HOST = 'nexus'
        NEXUS_PORT = '8081'
        TOMCAT_HOST = 'tomcat'
        TOMCAT_PORT = '8080'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your/repo.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    docker.image('maven:3.8.4-jdk-11').inside {
                        sh 'mvn clean install -DskipTests'
                    }
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    docker.image('sonarqube:8.9.2-community').withRun("-p ${SONARQUBE_PORT}:${SONARQUBE_PORT}") {
                        sh "mvn sonar:sonar -Dsonar.host.url=http://${SONARQUBE_HOST}:${SONARQUBE_PORT}"
                    }
                }
            }
        }

        stage('Deploy to Nexus') {
            steps {
                script {
                    docker.image('maven:3.8.4-jdk-11').inside {
                        sh 'mvn deploy -DskipTests'
                    }
                }
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                script {
                    docker.image('tomcat:9.0').withRun("-p ${TOMCAT_PORT}:${TOMCAT_PORT}") {
                        sh 'cp target/*.war /usr/local/tomcat/webapps/'
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                docker.image('maven:3.8.4-jdk-11').inside {
                    sh 'mvn clean'
                }
            }
        }
    }
}
```
