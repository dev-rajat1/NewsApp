# Project Overview: newsApp

## 1. High-Level Summary
**newsApp** is a native iOS application built using **Swift** and UIKit. The app serves as a news reader that fetches articles from [NewsAPI.org](https://newsapi.org/). It features a main feed with categories, a search functionality, a trending news section, and the ability for users to save their favorite articles locally.

## 2. Architecture & Design Pattern
The app generally follows a standard **MVC (Model-View-Controller)** architectural pattern typical of iOS apps built with UIKit and Storyboards.
- **Model**: `News.swift` (Data structures like `News`, `NewsResponse`, `Source`).
- **View**: Storyboard files (inside `Base.lproj`) and programmatic configurations for cells (`TableViewCell`, `CollectionCell`, etc.).
- **Controller**: Various `*VC.swift` files (`ViewController`, `NewsDetailVC`, `SaveVC`, `TrendingVC`, etc.).

## 3. Key Components & Files

### Data Models
- **`News.swift`**: Defines the `News`, `NewsResponse`, and `Source` structs. Implements `Codable` for JSON parsing.

### Networking / API Services
- **`APIService.swift`**: A singleton class (`APIService.shared`) that handles all network requests to NewsAPI.org using `URLSession`.
  - `getNews(category:page:pageSize:completion:)`: Fetches news by category with pagination support.
  - `searchNews(query:completion:)`: Searches for news articles based on a user query.
  - `getTrendingNews(page:pageSize:completion:)`: Fetches top headlines for the trending section.
  - **API Key**: Managed dynamically via `apiKey` property in `APIService` (reads `NEWS_API_KEY` from environment variables, `Info.plist`, or fallback placeholder).

### Local Storage
- **`SavedNewsManager.swift`**: A singleton class managing locally saved articles using `UserDefaults`. Uses `JSONEncoder` and `JSONDecoder` to store and retrieve arrays of `News` objects.

### Core View Controllers
- **`ViewController.swift`**: The main screen. Contains:
  - A `UITableView` for displaying news articles.
  - A `UICollectionView` for a horizontal scrollable category selector (General, Business, Entertainment, etc.).
  - A `UISearchBar` to search for articles.
  - Implements pagination when scrolling to the bottom of the table view.
- **`NewsDetailVC.swift`**: Displays the details of a specific news article. Likely contains options to read the full article or save it.
- **`SaveVC.swift`**: Displays the user's saved/bookmarked news articles (fetched via `SavedNewsManager`).
- **`TrendingVC.swift`**: Displays trending news articles (fetched via `APIService.getTrendingNews`).
- **`NewsWebKitVc.swift`**: Used to display the full news article web page using `WKWebView`.

### UI Cells
- **`TableViewCell.swift`**, **`TableViewCellSv.swift`**, **`TableViewCellTd.swift`**: Custom table view cells for different lists (main feed, saved, trending).
- **`CollectionCell.swift`**: Custom cell for the category selector collection view.

## 4. Dependencies
- **SDWebImage**: Used for asynchronous image downloading and caching (referenced in `ViewController.swift` as `import SDWebImage`).
- **NewsAPI.org**: External REST API used for fetching news data.

## 5. Potential Improvements / AI Actionable Items
If an AI agent is working on this codebase, the following are standard recommendations and areas for improvement:
- **API Key Security**: The API key is now moved out of hardcoded URLs into a configurable variable (`apiKey`), loaded from environment variables or `Info.plist`.
- **Dependency Management**: Check if `SDWebImage` is managed via CocoaPods, Carthage, or Swift Package Manager (SPM). Look for `Podfile` or `Package.swift` in the root if dependency changes are required.
- **Error Handling**: Network calls in `APIService` print errors to the console but return empty arrays to the UI. Propagating error messages to the UI (e.g., "No Internet Connection") would improve UX.
- **Code Duplication**: `APIService` has repetitive `URLSession` boilerplate. A generic network request function could refactor this.
