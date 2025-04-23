pipeline {
    agent any

    environment {
        IMAGE_NAME = "mi-app-docker-v2"
        CONTAINER_NAME = "mi-app-container-v2"
        GIT_REPO = "https://github.com/franklincappa/test-notifications-jenkins.git"
        GIT_BRANCH = "master"
    }

    stages {
        stage('Clonar Código') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Construir Imagen Docker') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Detener Contenedor Anterior') {
            steps {
                script {
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"
                }
            }
        }

        stage('Desplegar Nuevo Contenedor') {
            steps {
                sh "docker run -d --name ${CONTAINER_NAME} -p 5004:5004 ${IMAGE_NAME}"
            }
        }

        stage('Verificar Despliegue') {
            steps {
                sh "docker ps -a"
            }
        }
    }

    post {
        success {
            emailext subject: "✅ ÉXITO: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                     body: """Hola Franklin,
                        ✅ El pipeline *${env.JOB_NAME}* se ejecutó correctamente.
                        🔗 Ver detalles: ${env.BUILD_URL}
                        📁 Rama: ${env.BRANCH_NAME ?: 'master'}""",
                     to: 'fragotech.it@gmail.com'
        }

        failure {
            emailext subject: "❌ ERROR: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                     body: """Hola Franklin,
                     ❌ El pipeline *${env.JOB_NAME}* ha fallado.
                     🔗 Ver detalles: ${env.BUILD_URL}
                     📁 Rama: ${env.BRANCH_NAME ?: 'master'}
                     """,
                     to: 'fragotech.it@gmail.com'
        }
    }
}
