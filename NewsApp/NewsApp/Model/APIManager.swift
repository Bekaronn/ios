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
    
    private let apiKey = "edc11ddb80fa4abfafaae9cbda768b9b"
    
    //TopHeadliens
    static var country = "us"
    static var category = "business"
    
    //Everything
    static var sortBy = "publishedAt"
    
    //PageSize&Page
    static var pageSize = "15"
    static var page = "1"
    
    
    func getTopHeadlines(completion: @escaping (Result<[Article], Error>) -> Void){
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=\(apiKey)&country=\(APIManager.country)&category=\(APIManager.category)&pageSize=\(APIManager.pageSize)&page=\(APIManager.page)\(APIManager.qTopHeadlines)"
        
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
        let urlString = "https://newsapi.org/v2/everything?apiKey=\(apiKey)&sortBy=\(APIManager.sortBy)\(APIManager.qEverything)&pageSize=\(APIManager.pageSize)&page=\(APIManager.page)"
        
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
