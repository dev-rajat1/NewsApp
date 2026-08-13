import Foundation

class APIService {

    static let shared = APIService()
    
    func getNews(
        category: String,
        page: Int,
        pageSize: Int,
        completion: @escaping ([News]) -> Void
    ) {

        let urlString =
        "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&page=\(page)&pageSize=\(pageSize)&apiKey=cc08825e21ad4f6b9f020d35d4a2fb6c"

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
        "https://newsapi.org/v2/everything?q=\(encodedQuery)&apiKey=cc08825e21ad4f6b9f020d35d4a2fb6c"

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
        "https://newsapi.org/v2/top-headlines?country=us&page=\(page)&pageSize=\(pageSize)&apiKey=cc08825e21ad4f6b9f020d35d4a2fb6c"

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
