package com.ttnd.linksharing.enums

enum Seriousness {
    SERIOUS('Serious'), VERY_SERIOUS('Very Serious'), CASUAL('Casual')

    String displayText

    Seriousness(String displayText) {
        this.displayText = displayText
    }
}