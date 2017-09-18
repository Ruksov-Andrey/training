node('master') {
    stage('Git clone'){
       git url: 'https://github.com/Ruksov-Andrey/training.git', branch: 'task4'
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
            sh "curl -X PUT -u ${NEXUS_CREDENTIALS} -T ./build/libs/task4.war http://localhost:8081/nexus/content/repositories/snapshots/task4/${ver}/"
        }
    }
}



   stage ('Build image') {
        sh "docker build --build-arg VERSION=${ver} -t localhost:5000/task4:${ver} ."
		sh "docker push localhost:5000/task4:${ver}"
    }


}








