pipeline {

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git url:'https://github.com/dukes5555/docker-2048.git', branch:'master'
      }
    }

      stage("Build image") {
            steps {
                script {
                    myapp = docker.build("dukes5555/docker-2048:${env.BUILD_ID}")
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
          withKubeConfig([credentialsId: 'k8stoken_eksclustertest2_d2', serverUrl: 'https://0DE2BFAB8F2B9713C6D4A228829C7108.gr7.us-east-1.eks.amazonaws.com']) {
            script {
                    final String url = "https://raw.githubusercontent.com/dukes5555/aws-load-balancer-controller/main/docs/examples/2048/2048_full.yaml"

                    final String response = sh(script: "curl -s $url | sed 's=alb.ingress.kubernetes.io/target-type: ip=alb.ingress.kubernetes.io/target-type: instance=g' \
                    | kubectl apply -f - -n devteam2", returnStdout: true).trim()

                    echo response
                }
          }
        }
      }
  }

}
