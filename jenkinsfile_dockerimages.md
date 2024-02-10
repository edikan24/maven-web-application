Below is an example Jenkinsfile that demonstrates how to use Git, Maven, SonarQube, Nexus, and Tomcat as Docker images in a Jenkins pipeline:

```groovy
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

This Jenkinsfile defines a pipeline with the following stages:

1. **Checkout**: Clones the repository from Git.
2. **Build**: Builds the project using Maven inside a Maven Docker container.
3. **SonarQube Analysis**: Performs static code analysis using SonarQube.
4. **Deploy to Nexus**: Deploys the built artifacts to Nexus repository manager.
5. **Deploy to Tomcat**: Deploys the built WAR file to Tomcat.
6. **Cleanup**: Cleans up the workspace by running `mvn clean`.

Ensure you have the required Docker images (`maven`, `sonarqube`, `nexus`, `tomcat`) available in your Docker environment. You may need to configure credentials for Nexus if authentication is required for deployment. Additionally, adjust the URLs and ports in the `environment` block according to your Docker setup.
