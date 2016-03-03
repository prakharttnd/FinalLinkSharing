package com.ttnd.linksharing.enums


enum Visibility {
    PUBLIC('Public'), PRIVATE('Private')

    String displayText

    Visibility(String displayText){
        this.displayText = displayText
    }
}