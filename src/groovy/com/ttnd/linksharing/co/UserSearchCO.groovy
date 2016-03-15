package com.ttnd.linksharing.co

import com.ttnd.linksharing.enums.UserStatus

class UserSearchCO extends SearchCO {
    UserStatus isActive
    Integer max = 20
    Integer offset = 0
}
