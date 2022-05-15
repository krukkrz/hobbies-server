package io.github.krukkrz.common;

import java.util.Map;

public class HeaderUtils {
    public static Map<String, String> cleanHeaders(Map<String, String> headers) {
        headers.put("Authorization", "<token>");
        return headers;
    }
}
