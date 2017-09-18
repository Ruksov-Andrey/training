node('master') {
    stage('Git clone'){
       git url: 'https://github.com/Ruksov-Andrey/training.git', branch: 'task4'
    }
    stage('Build') {
        sh 'chmod +x gradlew && ./gradlew incVersion'
        sh 'chmod +x gradlew && ./gradlew build'
        
   }
    stage ('Upload to nexus') {
        withCredentials([usernameColonPassword(credentialsId: '1ddc8f7e-7ef5-40b6-9eca-2c28b06df6fd', variable: 'NEXUS_CREDENTIALS')]) {
            //Please install:    https://wiki.jenkins.io/display/JENKINS/Pipeline+Utility+Steps+Plugin           
            def props = readProperties  file: './gradle.properties'
            ver = props.MajorVersion+'.'+props.BuildNumber
            verB = props.BuildNumber
            println verB
            sh "curl -X PUT -u ${NEXUS_CREDENTIALS} -T ./build/libs/task4.war http://127.0.0.1:8081/nexus/content/repositories/snapshots/task4/${ver}/"
        }
    }
     stage ('Build image') {
        sh "docker build --build-arg VERSION=${ver} -t localhost:5000/task4:${ver} ."
        sh "docker push localhost:5000/task4:${ver}"
    }

    stage ('Run on SWARM SERVICE') {
       def r = sh script: 'docker service ls', returnStdout: true
       println r
       if(r.contains('tomcat')) {
           echo "--------------------UPDATE SERVICE for SWARM mode---------------------------"
           sh "docker pull 172.20.20.12:5000/task4:${ver}"
           sh "docker service update --detach=true --image 172.20.20.12:5000/task4:${ver}  tomcat"
        }
           else {
               echo "--------------------CREATE SERVICE for SWARM mode---------------------------"
               sh "docker pull 172.20.20.12:5000/task4:${ver}"
               sh "docker service create -detach=true --name=tomcat --mode global --publish 80:8080 172.20.20.12:5000/task4:${ver}"
           }
    }
    stage('VERIFY DEPLOY'){
        println 'Build: '+verB
        sleep 30
        def verify = httpRequest 'http://172.20.20.12/task4'
        if(verify.content.contains('Build: '+verB)){
            echo "--------------------DEPLOY SUCCESS---------------------------"
        }
        else {
            echo "--------------------DEPLOY FAILED----------------------------"
            currentBuild.result = 'DEPLOY FAILED'
        }
    }
    
    stage('push changes to task4 branch') {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'ea2d49f0-6ec3-41ff-a839-26c4c407108f', usernameVariable: 'git_USERNAME', passwordVariable: 'git_PASSWORD']]){
            sh 'git config --global user.name "Ruksov-Andrey"'
            sh 'git config --global user.email "theruksov@gmail.com"' 
            sh 'git add gradle.properties'
            sh "git commit -m 'increment version ${ver}'"
            sh "git push https://${git_USERNAME}:${git_PASSWORD}@github.com/Ruksov-Andrey/training.git task4"
            sh 'git checkout -f master'
            sh 'git merge task4'
            sh "git tag -a v${ver} -m 'release ${ver}'"
            sh "git push https://${git_USERNAME}:${git_PASSWORD}@github.com/Ruksov-Andrey/training.git --tag"
        }
    }
    
}
