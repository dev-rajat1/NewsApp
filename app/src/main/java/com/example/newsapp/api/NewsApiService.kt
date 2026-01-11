package com.example.newsapp.api

import android.R
import com.example.newsapp.model.NewsResponse
import org.intellij.lang.annotations.Language
import retrofit2.http.GET
import retrofit2.http.Query

interface NewsApiService {

    @GET("v2/everything")
    suspend fun getNews(
        @Query("q") query: String,
        @Query("language") language: String,
        @Query("apiKey") apiKey: String
    ): NewsResponse
}