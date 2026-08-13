import Foundation

class APIService {

    static let shared = APIService()
    
    /// News API key loaded from ProcessInfo environment variable `NEWS_API_KEY`,
    /// Info.plist key `NEWS_API_KEY`, or fallback to placeholder.
    private var apiKey: String {
        if let key = ProcessInfo.processInfo.environment["NEWS_API_KEY"], !key.isEmpty {
            return key
        }
        if let key = Bundle.main.object(forInfoDictionaryKey: "NEWS_API_KEY") as? String, !key.isEmpty {
            return key
        }
        return "YOUR_API_KEY_HERE"
    }
    
    func getNews(
        category: String,
        page: Int,
        pageSize: Int,
        completion: @escaping ([News]) -> Void
    ) {

        let urlString =
        "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&page=\(page)&pageSize=\(pageSize)&apiKey=\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in

            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }

            guard let data = data else {
                completion([])
                return
            }

            do {
                let result = try JSONDecoder()
                    .decode(NewsResponse.self, from: data)

                completion(result.articles)

            } catch {
                print(error)
                completion([])
            }

        }.resume()
    }
    func searchNews(
        query: String,
        completion: @escaping ([News]) -> Void
    ) {

        let encodedQuery =
        query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let urlString =
        "https://newsapi.org/v2/everything?q=\(encodedQuery)&apiKey=\(apiKey)"

        guard let url = URL(string: urlString) else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in

            guard let data = data else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }

            do {

                let result = try JSONDecoder()
                    .decode(NewsResponse.self, from: data)

                DispatchQueue.main.async {
                    completion(result.articles)
                }

            } catch {

                print(error)

                DispatchQueue.main.async {
                    completion([])
                }
            }

        }.resume()
    }
    
    func getTrendingNews(
        page: Int,
        pageSize: Int,
        completion: @escaping ([News]) -> Void
    ) {

        let urlString =
        "https://newsapi.org/v2/top-headlines?country=us&page=\(page)&pageSize=\(pageSize)&apiKey=\(apiKey)"

        guard let url = URL(string: urlString) else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in

            guard let data = data else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }

            do {
                let result = try JSONDecoder()
                    .decode(NewsResponse.self, from: data)

                DispatchQueue.main.async {
                    completion(result.articles)
                }

            } catch {
                print(error)

                DispatchQueue.main.async {
                    completion([])
                }
            }

        }.resume()
    }
}
