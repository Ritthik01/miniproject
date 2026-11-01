pipeline {
    agent any

    environment {
        COMPOSE_PROJECT = 'project'
        COMPOSE_FILE = 'docker-compose.yml'
        HEALTH_URL = 'http://host.docker.internal:5000/health'
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    python3 -m venv .venv
                    .venv/bin/python -m pip install --upgrade pip
                    .venv/bin/python -m pip install -r app/requirements.txt
                    .venv/bin/python -m pip install pytest
                '''
            }
        }

        stage('Automated Testing') {
            steps {
                sh '''
                    .venv/bin/python -m pytest tests/ -v
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker --version
                    docker-compose version

                    docker-compose \
                        -p "$COMPOSE_PROJECT" \
                        -f "$WORKSPACE/$COMPOSE_FILE" \
                        build webapp
                '''
            }
        }

        stage('Deploy Application') {
            steps {
                sh '''
                    docker-compose \
                        -p "$COMPOSE_PROJECT" \
                        -f "$WORKSPACE/$COMPOSE_FILE" \
                        up -d --no-deps webapp
                '''
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                    for i in $(seq 1 15); do
                        if curl -fsS "$HEALTH_URL"; then
                            echo "Application is healthy"
                            exit 0
                        fi

                        echo "Waiting for Flask application..."
                        sleep 2
                    done

                    echo "Health check failed"
                    docker-compose \
                        -p "$COMPOSE_PROJECT" \
                        -f "$WORKSPACE/$COMPOSE_FILE" \
                        logs webapp

                    exit 1
                '''
            }
        }
    }

    post {
        success {
            echo 'CI/CD pipeline completed successfully!'
        }

        failure {
            echo 'CI/CD pipeline failed. Check the console output.'
        }
    }
}
