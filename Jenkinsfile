pipeline {
   agent any  // Ensures the pipeline runs on a macOS machine

    environment {
        LANG = "en_US.UTF-8"
        LC_ALL = "en_US.UTF-8"
        FASTLANE_XCODEBUILD_SETTINGS_TIMEOUT = 120  // Time for Xcode settings
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/ayiosdeveloper/MVVM.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'bundle install'  // Use if you manage dependencies via Bundler
                sh 'pod install'  // Install CocoaPods dependencies
            }
        }

        stage('Code Linting') {
            steps {
                sh 'swiftlint'  // Runs SwiftLint for code style checks
            }
        }

        stage('Unit Tests') {
            steps {
                sh '''
                xcodebuild clean test \\
                -workspace JokeApp.xcworkspace \\
                -scheme JokeApp \\
                -sdk iphonesimulator \\
                -destination 'platform=iOS Simulator,name=iPhone 14,OS=latest' \\
                CODE_SIGNING_ALLOWED=NO
                '''
            }
        }

        stage('Build') {
            steps {
                sh 'fastlane build'  // Custom lane to handle build and archive
            }
        }

        stage('Deploy to TestFlight') {
            steps {
                sh 'fastlane beta'  // Custom lane to push the app to TestFlight
            }
        }
    }

    post {
        always {
            junit '**/test-results/*.xml'  // Publish test results
            archiveArtifacts artifacts: 'build/**/*.ipa', allowEmptyArchive: true
        }

        success {
            slackSend channel: '#ios-builds', message: 'Build Successful: ${env.BUILD_URL}'
        }

        failure {
            slackSend channel: '#ios-builds', message: 'Build Failed: ${env.BUILD_URL}'
        }
    }
}
