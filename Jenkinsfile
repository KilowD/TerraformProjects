pipeline {
    agent any
    
    tools {
        terraform 'jenkins-terraform'
    }
    stages {
        stage ("checkout from GIT") {
            steps {
                git branch: 'main', credentialsId: '62c45719-2784-471e-af2d-418da7b8258d', url: 'https://github.com/KilowD/TerraformProjects.git'
            }
        }
        stage ("terraform init") {
            steps {
                bat 'terraform init'
            }
        }
        stage ("terraform fmt") {
            steps {
                bat 'terraform fmt'
            }
        }
        stage ("terraform validate") {
            steps {
                bat 'terraform validate'
            }
        }
        stage ("terrafrom plan") {
            steps {
                bat 'terraform plan '
            }
        }
        stage ("terraform apply") {
            steps {
                bat 'terraform apply --auto-approve'
            }
        }
    }
}