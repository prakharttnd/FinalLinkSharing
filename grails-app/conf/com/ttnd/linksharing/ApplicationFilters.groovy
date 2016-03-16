package com.ttnd.linksharing

class ApplicationFilters {

    def filters = {

        loggingparams(controller: '*', action: '*') {
            before = {
                log.info "<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>"
                log.info controllerName
                log.info actionName
                log.info params
                log.info "<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>"
            }
        }

        all(controller: '*', action: '*', controllerExclude: 'user') {
            before = {
                if (!session.user && !controllerName.equals("base")) {
                    redirect(controller: 'user', action: 'index')
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }

        loginCheck(controller: 'user', action: 'index') {
            before = {
                if (session.user) {
                    redirect(controller: 'user', action: 'dashboard')
                }
            }
        }

        logincheck(controller: 'user', action: 'dashboard') {
            before = {
                if (!session.user) {
                    redirect(controller: 'user', action: 'index')
                }
            }
        }

        consoleAccessbyAdmin(controller: 'console', action: '*') {
            before = {
                if (session.user) {
                    if (!session.user.admin) {
                        redirect(uri: '/')
                    }
                }
            }
        }
    }
}
