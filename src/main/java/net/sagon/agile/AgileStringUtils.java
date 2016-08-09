package net.sagon.agile;

import org.springframework.util.DigestUtils;

public class AgileStringUtils {

    public static String hash(String source) {
        return DigestUtils.md5DigestAsHex(source.getBytes());
    }

}
