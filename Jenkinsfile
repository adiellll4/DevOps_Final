pipeline {
    agent any

    parameters {
        string(name: 'NAME', defaultValue: 'John Doe', description: 'Enter your name')
        string(name: 'AGE', defaultValue: '30', description: 'Enter your age')
    }

    stages {
        stage('Validate Input & Calculate Year of Birth') {
            steps {
                script {
                    def name = params.NAME.trim()
                    def age = params.AGE.trim()
                    def currentYear = new Date().format("yyyy").toInteger()
                    def outputMessage = ""

                    // בדיקת שם – חייב להכיל רק אותיות ורווחים (ללא מספרים/תווים מיוחדים)
                    if (!(name ==~ /^[A-Za-z\s]+$/)) {
                        outputMessage = "<h2 style='color:red;'>Invalid Input: Name must contain only letters and spaces.</h2>"
                        echo "Invalid name input!"
                    } else if (!age.isInteger()) {
                        outputMessage = "<h2 style='color:red;'>Invalid Input: Age must be a valid number.</h2>"
                        echo "Invalid age input!"
                    } else {
                        def ageInt = age.toInteger()
                        if (ageInt > 0 && ageInt < 150) {
                            def birthYear = currentYear - ageInt
                            outputMessage = "<h2>Hello ${name}!</h2><p>Your estimated birth year is: <strong>${birthYear}</strong></p>"
                            echo "Valid input. Calculated birth year: ${birthYear}"
                        } else {
                            outputMessage = "<h2 style='color:red;'>Invalid Input: Age must be a positive number less than 150.</h2>"
                            echo "Invalid age input!"
                        }
                    }

                    // שמירת הפלט בקובץ HTML להצגה ב-Jenkins
                    writeFile file: 'output.html', text: """
                        <html>
                        <head><title>Jenkins Output</title></head>
                        <body>
                        ${outputMessage}
                        </body>
                        </html>
                    """
                }
            }
        }
    }

    post {
        always {
            // פרסום הקובץ ב-Jenkins HTML Publisher Plugin
            publishHTML(target: [
                allowMissing: false,
                alwaysLinkToLastBuild: true,
                keepAll: true,
                reportDir: '',
                reportFiles: 'output.html',
                reportName: 'User Data Output'
            ])
        }
    }
}
