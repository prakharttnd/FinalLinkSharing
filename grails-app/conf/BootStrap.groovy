class BootStrap {

    def grailsApplication

    def init = { servletContext ->
        def folder = new File(grailsApplication.config.serverURL)
        if (!folder.exists()) {
            folder.mkdirs();
        }
    }
    def destroy = {
    }
}
