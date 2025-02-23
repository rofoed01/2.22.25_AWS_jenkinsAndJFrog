pipeline {
    agent any
    environment {
        AWS_REGION = 'us-west-2' 
    }
    stages {
        stage('Set AWS Credentials') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AWS-Jenkins' 
                ]]) {
                    sh '''
                    echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
                    aws sts get-caller-identity
                    '''
                }
            }
        }
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/rofoed01/2.22.25_AWS_jenkinsAndJFrog' 
            }
        }

        stage('jFrog Artifactory') {
            steps {
                withCredentials([string(credentialsId: 'jfrog-credentials', variable: 'JFROG_TOKEN')]) {
                // Show the installed version of JFrog CLI
                jf '-v'
                
                // Show the configured JFrog Platform instances
                jf 'c show'
                
                // Ping Artifactory
                jf 'rt ping'
                
                // Create a file and upload it to the repository
                sh 'touch test-file'
                // Fixed upload command syntax
                sh 'jf rt upload test-file tf-terraform/ --url= https://trial8m9574.jfrog.io//artifactory --user=skyline7002@gmail.com --password=$JFROG_TOKEN'
                
                // Publish the build-info to Artifactory
                jf 'rt bp'
                
                // Fixed download command syntax
                sh 'jf rt download tf-terraform/test-file --url= https://trial8m9574.jfrog.io//artifactory --user=skyline7002@gmail.com --password=$JFROG_TOKEN'
        }
    } 
        }


        stage('Initialize Terraform') {
            steps {
                sh '''
                terraform init
                '''
            }
        }
        stage('Plan Terraform') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AWS-Jenkins'
                ]]) {
                    sh '''
                    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                    terraform plan -out=tfplan
                    '''
                }
            }
        }
        stage('Apply Terraform') {
            steps {
                input message: "Approve Terraform Apply?", ok: "Deploy"
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AWS-Jenkins'
                ]]) {
                    sh '''
                    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                    terraform apply -auto-approve tfplan
                    '''
                }
            }
        }
        stage ('Destroy Terraform') {
            steps {
                input message: "Do you want to destroy the infrastructure?", ok: "Destroy"
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AWS-Jenkins'
                ]]) {
                    sh '''
                    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                    terraform destroy -auto-approve
                    '''
                }
            }
        }
    }
    post {
        success {
            echo 'Terraform deployment completed successfully!'
        }
        failure {
            echo 'Terraform deployment failed!'
        }
    }
}
