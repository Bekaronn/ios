//
//  NewsArticle.swift
//  NewsApp
//
//  Created by Bekarys on 02.03.2024.
//

import Foundation

struct NewsArticle {
    let apiManager = APIManager()
    private var articles: [Article] = []
    
    func getNews(){
        APIManager.shared.getTopHeadlines { result in
            switch result {
            case .success(let articles):
                print("\(articles.count) articles")
                self.articles = articles
            case .failure(let error):
                print("Error")
            }
        }
    }
}
