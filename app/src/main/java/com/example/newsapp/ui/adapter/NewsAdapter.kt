package com.example.newsapp.ui.adapter

import android.content.Context
import android.content.Intent
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.example.newsapp.databinding.ItemNewsBinding
import com.example.newsapp.model.Article
import com.example.newsapp.ui.WebViewActivity

class NewsAdapter(
    private val context: Context,
    private val articles: MutableList<Article>
) : RecyclerView.Adapter<NewsAdapter.NewsViewHolder>() {

    // 🔹 ViewHolder
    inner class NewsViewHolder(val binding: ItemNewsBinding) :
        RecyclerView.ViewHolder(binding.root)

    // 🔹 Create ViewHolder
    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): NewsViewHolder {

        val binding = ItemNewsBinding.inflate(
            LayoutInflater.from(parent.context),
            parent,
            false
        )
        return NewsViewHolder(binding)
    }

    // 🔹 Bind Data
    override fun onBindViewHolder(
        holder: NewsViewHolder,
        position: Int
    ) {

        val article = articles[position]   // ✅ SAME LIST (NO CRASH)

        holder.binding.apply {

            tvTitle.text = article.title ?: "No Title"
            tvDescription.text = article.description ?: "No Description"

            Glide.with(context)
                .load(article.urlToImage)
                .centerCrop()
                .into(imgNews)

            // 🔹 Open WebView on click
            root.setOnClickListener {
                val intent = Intent(context, WebViewActivity::class.java)
                intent.putExtra("url", article.url)
                context.startActivity(intent)
            }
        }
    }

    // 🔹 List Size
    override fun getItemCount(): Int = articles.size

    // 🔹 Update data safely
    fun updateData(newList: List<Article>) {
        articles.clear()
        articles.addAll(newList)
        notifyDataSetChanged()
    }
}