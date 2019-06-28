node {
    stage 'Checkout'
        checkout scm

    stage 'Build'
      	buildStatus= sh returnStatus: true, script:"xcodebuild -scheme 'Backbase-Assignment' -configuration 'Debug' build -destination 'platform=iOS Simulator,name=iPhone 6,OS=12.2'" 
      	echo "Build status : ${buildStatus}"
}
