node {
    stage 'Checkout'
        checkout scm

    stage 'Build'
      	buildStatus= sh returnStatus: true, script:"xcodebuild -scheme "BackbaseAssignment" -configuration "Debug" build" 
      	echo "Build status : ${buildStatus}"
}
