package com.example.newsapp.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.newsapp.model.Article
import com.example.newsapp.repository.NewsRepository
import kotlinx.coroutines.launch

class NewsViewModel : ViewModel() {

    private val repo = NewsRepository()
     val news = MutableLiveData<List<Article>>()
    fun fetchNews() {
        viewModelScope.launch {
            try {
                val response = repo.getTopHeadlines()   // Repository se call
                news.value = response.articles
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }
}