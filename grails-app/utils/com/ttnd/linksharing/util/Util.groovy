package com.ttnd.linksharing.util

class Util {

    static String generateRandomPassword() {
        Random rnd = new Random();
        String n = 100000 + rnd.nextInt(900000) + "";
        return n;
    }
}
