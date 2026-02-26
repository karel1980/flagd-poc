package com.example.flagd_poc

import dev.openfeature.sdk.Client
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class HelloController(val featureClient: Client) {

    @GetMapping("/hello")
    fun hello(): String {
        val uppercase = featureClient.getBooleanValue("uppercase", false)

        val msg = "Hello World!"

        return if (uppercase) msg.uppercase() else msg
    }

    @GetMapping("/hello-details")
    fun helloDetails() = featureClient.getBooleanDetails("uppercase", false)
}