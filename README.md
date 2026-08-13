# NewsApp 📰

A native iOS application built with **Swift** and **UIKit** that allows users to read the latest news, search for specific topics, browse categories, and save their favorite articles for later reading.

## Features ✨

*   **Top Headlines:** Stay updated with the latest news from around the world.
*   **Categories:** Browse news by categories such as Business, Entertainment, Health, Science, Sports, and Technology.
*   **Search Functionality:** Easily search for specific news articles and topics.
*   **Trending Section:** Discover what's currently trending in the news.
*   **Save Articles (Bookmarks):** Save your favorite articles locally to read them later, even offline.
*   **In-App Web View:** Read full articles directly within the app using `WKWebView`.

## Tech Stack 🛠️

*   **Language:** Swift
*   **UI Framework:** UIKit (Storyboards & Programmatic UI)
*   **Architecture:** MVC (Model-View-Controller)
*   **Networking:** `URLSession` (Fetching data from [NewsAPI.org](https://newsapi.org/))
*   **Image Caching:** [SDWebImage](https://github.com/SDWebImage/SDWebImage) for smooth, asynchronous image loading.
*   **Local Storage:** `UserDefaults` for saving bookmarked articles.

## Requirements 📱

*   iOS 13.0+
*   Xcode 11.0+
*   Swift 5.0+

## Setup & Installation 🚀

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/dev-rajat1/newsApp.git
    ```
2.  **Open the project:**
    Open `newsApp.xcodeproj` in Xcode.
3.  **API Key Configuration:**
    *   The app uses [NewsAPI](https://newsapi.org/).
    *   *Note:* A default API key is currently included in `APIService.swift` for demonstration purposes. For production, please replace it with your own API key.
4.  **Run the app:**
    Select a simulator or a physical device and press `Cmd + R` to run the app.

## Acknowledgements 🙏
*   Data provided by [NewsAPI.org](https://newsapi.org/)

---
*Created by [dev-rajat1](https://github.com/dev-rajat1)*
