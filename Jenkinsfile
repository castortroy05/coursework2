pipeline {
    environment {
     imagename = "castortroy05/coursework2"
     registryCredential = 'dockerhub_id'
    dockerImage = ''   
    }
    agent any
    stages {
        stage('Cloning Git') {
		steps {
			git([url: 'https://github.com/castortroy05/coursework2.git', branch: 'main', credentialsId: 'github_id'])}}

      stage('Sonarqube') {
          environment {
              scannerHome = tool 'SonarQubeScanner'
                }
        
          steps {
              withSonarQubeEnv('sonarqube') {
                  sh "${scannerHome}/bin/sonar-scanner"
                  }
             // timeout(time: 5, unit: 'MINUTES') {
               //   waitForQualityGate abortPipeline: true
                 // }
          }
      }

        stage('Building image') {
                steps{
                    script {
                        dockerImage = docker.build imagename}}
				}
	    
        stage('Upload Image to Docker') {
		steps{
		    script {
			docker.withRegistry( '', registryCredential ) {
			dockerImage.push("$BUILD_NUMBER")
			dockerImage.push('latest')}}}
}
        stage('Remove unused docker image') {
  		steps{
	    		sh "docker rmi $imagename:$BUILD_NUMBER"
  }
}
        stage ('Deploy to minikube') {
     		steps{
         		script {
			echo 'Using remote command over ssh'
			sh 'ssh ubuntu@18.210.15.221 kubectl set image deployments/coursework2 cw2=castortroy05/coursework2:"$BUILD_NUMBER"'}
     }
    }
      
        
    }
}

  

