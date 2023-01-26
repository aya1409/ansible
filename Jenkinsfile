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
                    sh "scp -o StrictHostKeyChecking=no ansible/* root@${ANSIBLE_SERVER}:/root/"
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
                 sshScript remote: remote, scripts: "prepare_ansible-server.sh"
                 sshCommand remote: remote, command: "ansible-playbook deploy-docker-with-roles.yaml"

                //  withCredentials([sshUserPrivateKey(credentialsId: "ansible-server-key", KeyFileVariable: 'keyfile',usernameVariable: 'root')])
                // {
                //  remote.user = user
                //  remote.identityFile = keyfile
                //  sshScript remote: remote, scripts: "prepare_ansible-server.sh"
                //  sshCommand remote: remote, command: "ansible-playbook deploy-docker-linux.yaml"
                // }
                  
            }

            }
        }
    }
}
       