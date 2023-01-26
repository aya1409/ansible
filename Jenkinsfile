pipeline {
    agent any
    environment{
        ANSIBLE_SERVER = "138.68.66.94"

    }
    stages {
        stage('copie file to ansible server') {
            steps {
              script{
                 echo"coping all necessary files to ansible controle node"
                 sshagent(['ansible-server-key']){
                    sh "scp -r -o StrictHostKeyChecking=no ansible/* root@${ANSIBLE_SERVER}:/root/"
                }
                }
            }
        }
               stage('execute ansible playbook file') {
            steps {
              script{
                 echo"calling ansible playbook file"
                 def remote = [:]
                 remote.name = "root"
                 remote.host = ANSIBLE_SERVER
                 remote.allowAnyHosts = true
                 
                // yemchi ll jenkins w ychouf l credential li 3andou id ansible-server-key li ani zedou el private key mta3 jenkins docker ece w fazzet 
                // w heka ye5ou deux variable el el private key li ani 9otlou 3oud samihouli keyfile
                // w user li ani 9otlou samihouli user
                // ramez howa ye5ou deux var w y7ot fehom les contenue mta3 les creden
                 withCredentials([sshUserPrivateKey(credentialsId: "ansible-server-key", keyFileVariable: 'keyfile', usernameVariable: 'user')])
                {
                 remote.user = user
                 remote.identityFile = keyfile
                 sshScript remote: remote, script: "prepare_ansible-server.sh"
                 sshCommand remote: remote, command: "ansible-playbook deploy-docker-with-roles.yaml"
                }
                  
            }

            }
        }
    }
}
       