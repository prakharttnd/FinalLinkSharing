package com.ttnd.linksharing.enums

enum UserStatus {
    All_USERS("All Users"), ACTIVE("Active"), INACTIVE("Inactive")

    String displayText

    UserStatus(String displayText) {
        this.displayText = displayText
    }

}