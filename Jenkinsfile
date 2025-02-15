pipeline {
    agent any

    parameters {
        string(name: 'NAME', defaultValue: 'Adiel', description: 'Enter name')
        string(name: 'BIRTHDAY', defaultValue: '1', description: 'Enter birthday (1-31)')
        string(name: 'BIRTHMONTH', defaultValue: '1', description: 'Enter birth month (1-12)')
    }

    environment {
        OUTPUT_FILE = 'output.html'
    }

    stages {
        stage('Validate Parameters') {
            steps {
                script {
                    // ולידציה למשתנה NAME - אך ורק אותיות
                    if (!params.NAME.matches("[a-zA-Z]+")) {
                        error "NAME must contain only letters (no numbers or special characters)."
                    }

                    // ולידציה למשתנה BIRTHDAY - רק מספרים בין 1 ל-31
                    def birthday = params.BIRTHDAY.toInteger()
                    if (birthday < 1 || birthday > 31) {
                        error "BIRTHDAY must be a number between 1 and 31."
                    }

                    // ולידציה למשתנה BIRTHMONTH - רק מספרים בין 1 ל-12
                    def birthMonth = params.BIRTHMONTH.toInteger()
                    if (birthMonth < 1 || birthMonth > 12) {
                        error "BIRTHMONTH must be a number between 1 and 12."
                    }
                }
            }
        }

        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/adiellll4/DevOps_Final.git'

              //  git 'https://github.com/adiellll4/DevOps_Final.git'  // Replace with your repository URL
            }
        }

        stage('Run Shell Script') {
            steps {
                script {
                    // משתנים חדשים, אני משתמש בפרמטרים NAME, BIRTHDAY ו- BIRTHMONTH
                    def output = sh(script: "bash FinalProject.sh ${params.NAME} ${params.BIRTHDAY} ${params.BIRTHMONTH}", returnStdout: true).trim()
                    writeFile file: OUTPUT_FILE, text: "<html><body><h1>Output</h1><p>${output}</p></body></html>"
                }
            }
        }

        stage('Display Parameter') {
            steps {
                script {
                    currentBuild.description = "Name: ${params.NAME}, Birthday: ${params.BIRTHDAY}, Birth Month: ${params.BIRTHMONTH}"
                }
            }
        }

        stage('Verify Parameter on Web Page') {
            steps {
                script {
                    def description = currentBuild.description
                    if (description.contains("${params.NAME}")) {
                        echo "Parameter ${params.NAME} exists on the web page."
                    } else {
                        error "Parameter ${params.NAME} does not exist on the web page."
                    }
                }
            }
        }

        stage('Send HTTP Request') {
            steps {
                script {
                    // שליחה ל-HTTP endpoint עם תוצאה מה-pipeline
                    def response = httpRequest(
                        acceptType: 'APPLICATION_JSON', 
                        contentType: 'APPLICATION_JSON', 
                        httpMode: 'POST', 
                        url: 'https://your-api-endpoint.com/your-path', 
                        requestBody: '{"name": "${params.NAME}", "birthday": "${params.BIRTHDAY}", "birthMonth": "${params.BIRTHMONTH}", "output": "${sh(script: "cat ${OUTPUT_FILE}", returnStdout: true).trim()}"}'
                    )
                    echo "Response: ${response}"
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: OUTPUT_FILE, fingerprint: true
            publishHTML(target: [
                allowMissing: false,
                alwaysLinkToLastBuild: true,
                keepAll: true,
                reportDir: '.',
                reportFiles: OUTPUT_FILE,
                reportName: 'Shell Script Output'
            ])
        }
    }
}
