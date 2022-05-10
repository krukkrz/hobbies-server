package io.github.krukkrz;

import io.javalin.Javalin;

public class App {
    public static void main(String[] args) {
        var app = Javalin.create().start(8081);
        app.get("/hello", ctx -> ctx.result("Hello world!"));
    }
}
