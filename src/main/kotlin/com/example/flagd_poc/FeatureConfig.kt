package com.example.flagd_poc

import dev.openfeature.contrib.providers.flagd.FlagdOptions
import dev.openfeature.contrib.providers.flagd.FlagdProvider
import dev.openfeature.sdk.OpenFeatureAPI
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
class FeatureConfig {
    @Value("\${flagd.host:localhost}")
    lateinit var flagDHost: String

    @Bean
    fun featureClient() = OpenFeatureAPI.getInstance()
        .apply {
            this.provider = FlagdProvider(
                FlagdOptions.builder()
                    .host(flagDHost)
                    .build()
            )
        }.client
}