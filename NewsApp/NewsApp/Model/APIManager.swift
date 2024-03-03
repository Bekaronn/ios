//
//  APIManager.swift
//  NewsApp
//
//  Created by Bekarys on 02.03.2024.
//

import Foundation

struct NewsResponse: Codable {
    var articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}

class APIManager {
    static let shared = APIManager()
    private let apiKey = "e65ee0938a2a43ebb15923b48faed18d"
    
    func getTopHeadlines(completion: @escaping (Result<[Article], Error>) -> Void){
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                print("no data")
                return
            }
            do {
                let newsResponse = try JSONDecoder().decode(NewsResponse.self , from: data)
                completion(.success(newsResponse.articles))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
