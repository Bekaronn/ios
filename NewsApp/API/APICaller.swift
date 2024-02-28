import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let apiKey = "e65ee0938a2a43ebb15923b48faed18d"
        static let topHeadlinesURL = URL(
             string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)"
        )
        static let everythingURL = URL(
             string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=\(apiKey)"
        )
        static let searchURLString =  "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=\(apiKey)&q="
    }
    private init() {}
    
    
    public func getTopHeadlines(completion: @escaping (Result<[Article],Error>) -> Void){
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                    
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getEverything(completion: @escaping (Result<[Article],Error>) -> Void){
        guard let url = Constants.everythingURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                    
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    
    public func search(with query: String, completion: @escaping (Result<[Article],Error>) -> Void){
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlString = Constants.searchURLString + query
        guard  let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data{
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
