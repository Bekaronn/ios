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
    static var qTopHeadlines = ""
    static var qEverything = "&q=bitcoin"
    
    private let apiKey = "e65ee0938a2a43ebb15923b48faed18d"
    
    //TopHeadliens
    private var country = "&country=us"
    private var category = "&category=business"
    
    //Everything
    private var language = "&language=en"
    private var sortBy = "&sortBy=publishedAt"
    
    //PageSize&Page
    private var pageSize = "&pageSize=15"
    private var page = "&page=1"
    
    
    func getTopHeadlines(completion: @escaping (Result<[Article], Error>) -> Void){
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=\(apiKey)\(country)\(category)\(pageSize)\(page)\(APIManager.qTopHeadlines)"
        
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
    
    
    func getEverything(completion: @escaping (Result<[Article], Error>) -> Void){
        let urlString = "https://newsapi.org/v2/everything?apiKey=\(apiKey)\(language)\(sortBy)\(APIManager.qEverything)\(pageSize)\(page)"
        
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
