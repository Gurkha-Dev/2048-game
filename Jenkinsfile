pipeline {

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git url:'https://github.com/dukes5555/2048-game.git', branch:'master'
      }
    }

      stage("Build image") {
            steps {
                script {
                    myapp = docker.build("dukes5555/2048-game:${env.BUILD_ID}")
                }
            }
        }

      stage("Push image") {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                            myapp.push("latest")
                            myapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }


      stage('Deploy k8s') {
        steps {
          withKubeConfig([credentialsId: 'k8s_121120', serverUrl: 'https://318D17E17FA96D6856DCA6249637B3FC.gr7.us-east-1.eks.amazonaws.com']) {
            script {
                    sh '''
                      cat 2048_game.yaml | sed 's@{{build_version}}@${env.BUILD_ID}@;' | kubectl -n devteam1 apply -f -
                      '''}
          }
        }
      }
  }

}
