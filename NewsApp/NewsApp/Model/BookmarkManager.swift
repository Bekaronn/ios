//
//  BookmarkManager.swift
//  NewsApp
//
//  Created by Bekarys on 05.03.2024.
//

import Foundation

class BookmarkManager {
    static var bookmarks: [ArticleViewModel] = []
    
    static func contains(_ article: ArticleViewModel) -> Bool {
        return bookmarks.contains(article)
    }
    
}
