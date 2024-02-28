//import Foundation
//
//
//struct APIResponse: Codable {
//    let articles: [Article]
//}
//
//struct Article: Codable {
//    let source: Source
//    let title: String
//    let description: String?
//    let url: String?
//    let urlToImage: String?
//    let publishedAt: String
//}
//
//struct Source: Codable {
//    let name: String
//}
//
//class APIClient {
////    static let apiKey = "e65ee0938a2a43ebb15923b48faed18d"
////    static let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)"
//    
//    static func getTopHeadlines(completion: @escaping (Result<[Article], Error>) -> Void) {
//        let urlString = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=3738013b0fe84f2b8339b09f5b068900")
//        
//        guard let url = urlString else {
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) {data, response, error in
//            if let error = error {
//                completion(.failure(error))
//            }
//            else if let data = data {
//                do {
//                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
//                    completion(.success(result.articles))
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//        }
//        
//        task.resume()
//    }
//}
