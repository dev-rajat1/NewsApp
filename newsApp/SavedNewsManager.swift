import Foundation

class SavedNewsManager {

    static let shared = SavedNewsManager()

    private let key = "savedNews"

    func isSaved(_ news: News) -> Bool {
        let saved = getSavedNews()
        return saved.contains(where: { $0.title == news.title })
    }
    
    @discardableResult
    func toggleSave(_ news: News) -> Bool {
        var saved = getSavedNews()
        if let index = saved.firstIndex(where: { $0.title == news.title }) {
            saved.remove(at: index)
            if let data = try? JSONEncoder().encode(saved) {
                UserDefaults.standard.set(data, forKey: key)
            }
            return false // Now unsaved
        } else {
            saved.insert(news, at: 0)
            if let data = try? JSONEncoder().encode(saved) {
                UserDefaults.standard.set(data, forKey: key)
            }
            return true // Now saved
        }
    }

    func saveNews(_ news: News) -> Bool {

        var saved = getSavedNews()
        
        if saved.contains(where: { $0.title == news.title }) {
            return false
        }

        saved.insert(news, at: 0)

        if let data = try? JSONEncoder().encode(saved) {
            UserDefaults.standard.set(data, forKey: key)
            
        }
        return true
    }

    func getSavedNews() -> [News] {

        if let data = UserDefaults.standard.data(forKey: key),
           let news = try? JSONDecoder().decode([News].self, from: data) {
            return news
        }

        return []
    }

    func removeNews(at index: Int) {

        var saved = getSavedNews()
        saved.remove(at: index)

        if let data = try? JSONEncoder().encode(saved) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
