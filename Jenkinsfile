node {
    def scmVars = checkout scm
    def imageName = "willwangkelda/hotrod-route:release-${scmVars.GIT_COMMIT}"
    stage('Build') {
        def image = docker.build(imageName)
        image.push()
    }
    stage('Test') {
        docker.image(imageName).withRun('-p 8083:8083') { c ->
          sh 'python route_unit_test.py localhost'
        }
    }
    stage('Deploy') {
        // Skip
    }
}
