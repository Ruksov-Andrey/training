node('master') {
    stage('Git clone'){
       git url: 'https://github.com/Ruksov-Andrey/training.git', branch: 'task3'
    }

    stage('Build') {
        sh 'chmod +x gradlew && ./gradlew incVersion'
        sh 'chmod +x gradlew && ./gradlew build'}

    stage ('Upload to nexus') {

        withCredentials([usernameColonPassword(credentialsId: '4f1db46f-1b2a-43d7-9b72-79574e449aaf', variable: 'NEXUS_CREDENTIALS')]) {
        def props = readProperties  file: './gradle.properties'
        ver = props.MajorVersion+'.'+props.BuildNumber
        verB = props.BuildNumber
        println verB
        sh "curl -X PUT -u ${NEXUS_CREDENTIALS} -T ./build/libs/task3.war http://localhost:8081/nexus/content/repositories/snapshots/task3/${ver}/"
        }
    }
}

node('TOMCAT1') {
    stage('STOP TOMCAT1') {
        httpRequest responseHandle: 'NONE', url: 'http://172.20.20.12/jkmanager?cmd=update&from=list&w=lb&sw=tomcat1&vwa=1'
    }
    stage('Copy WAR in webapps') {
        sh 'rm -r /home/jenkins/workspace/task3/*'
        sh "wget http://172.20.20.12:8081/nexus/content/repositories/snapshots/task3/${ver}/task3.war"
        sh 'cp -f /home/jenkins/workspace/task3/task3.war /usr/share/tomcat/webapps'
    }
        sleep 15
               
    stage('VEREFY DEPLOY'){
        println 'Build: '+verB
        def verify = httpRequest 'http://172.20.20.10:8080/task3'
        if(verify.content.contains('Build: '+verB)){
        echo "--------------------DEPLOY SUCCESS---------------------------"
    }
        else {
        echo "--------------------DEPLOY FAILED---------------------------"
        currentBuild.result = 'ABORTED'
        }
    }
    stage('START TOMCAT1'){
        httpRequest responseHandle: 'NONE', url: 'http://172.20.20.12/jkmanager?cmd=update&from=list&w=lb&sw=tomcat1&vwa=0'
    }
}

node('TOMCAT2') {
    stage('STOP TOMCAT2') {
        httpRequest responseHandle: 'NONE', url: 'http://172.20.20.12/jkmanager?cmd=update&from=list&w=lb&sw=tomcat1&vwa=1'
    }
    stage('Copy WAR in webapps') {
        sh 'rm -r /home/jenkins/workspace/task3/*'
        sh "wget http://172.20.20.11:8081/nexus/content/repositories/snapshots/task3/${ver}/task3.war"
        sh 'cp -f /home/jenkins/workspace/task3/task3.war /usr/share/tomcat/webapps'
    }
        sleep 15
               
    stage('VEREFY DEPLOY'){
        println 'Build: '+verB
        def verify = httpRequest 'http://172.20.20.10:8080/task3'
        if(verify.content.contains('Build: '+verB)){
        echo "--------------------DEPLOY SUCCESS---------------------------"
        }
        else {
        echo "--------------------DEPLOY FAILED---------------------------"
        currentBuild.result = 'ABORTED'
        }
    }
    stage('START TOMCAT2'){
        httpRequest responseHandle: 'NONE', url: 'http://172.20.20.11/jkmanager?cmd=update&from=list&w=lb&sw=tomcat1&vwa=0'
    }
}

node('master') { 
    stage('push changes to task3 branch') {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: '73e1d50e-4849-4e0c-a465-ade566d14efc', usernameVariable: 'git_USERNAME', passwordVariable: 'git_PASSWORD']]){
        sh 'git config --global user.name "Ruksov-Andrey"'
        sh 'git config --global user.email "theruksov@gmail.com"' 
        sh 'git add gradle.properties'
        sh "git commit -m 'increment version ${ver}'"
        sh "git push https://${git_USERNAME}:${git_PASSWORD}@github.com/Ruksov-Andrey/training.git task3"
        sh 'git checkout -f master'
        sh 'git merge task3'
        sh "git tag -a v${ver} -m 'release ${ver}'"
        sh "git push https://${git_USERNAME}:${git_PASSWORD}@github.com/Ruksov-Andrey/training.git --tag"
        }
    }
}
