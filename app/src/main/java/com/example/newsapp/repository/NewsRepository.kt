package com.example.newsapp.repository

import com.example.newsapp.api.RetrofitInstance
import com.example.newsapp.model.NewsResponse
import com.example.newsapp.util.Constants

class NewsRepository {

    suspend fun getTopHeadlines(): NewsResponse {
        return RetrofitInstance.api.getNews(
            query = "india",
           language = "en",
            apiKey = Constants.API_KEY
        )
    }
}