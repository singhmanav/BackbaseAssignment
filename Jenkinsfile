node {
    stage 'Checkout'
    checkout scm

    stage 'Build'
      	buildStatus= sh returnStatus: true, script:"sh 'xcodebuild -scheme "TimeTable" -configuration "Debug" build test -destination "platform=iOS Simulator,name=iPhone 6,OS=10.1" -enableCodeCoverage YES | /usr/local/bin/xcpretty -r junit'" 
      	echo "Build status : ${buildStatus}"
}
