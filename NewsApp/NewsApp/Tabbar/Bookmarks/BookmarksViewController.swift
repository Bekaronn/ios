//
//  BookmarksViewController.swift
//  NewsApp
//
//  Created by Bekarys on 03.03.2024.
//

import UIKit
import SafariServices

class BookmarksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var allBookmarkButton: UIButton!
    
    private var articles: [ArticleViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchBookmarks()
    }
    
    @IBAction func refreshButton(_ sender: UIButton) {
        refresh()
    }
    
    
    @IBAction func allBookmarkButton(_ sender: UIButton) {
        BookmarkManager.bookmarks = []
        refresh()
    }
    
    private func fetchBookmarks() {
        self.articles = BookmarkManager.bookmarks
        self.tableView.reloadData()
    }
    
    func refresh() {
        fetchBookmarks()
        print(articles)
        self.tableView.reloadData()
    }
    
}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(articles.count)
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarksCell", for: indexPath) as! BookmarksTableViewCell
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.description
        
        if let data = article.imageData {
            cell.newsImage.image = UIImage(data: data)
        }
        else if let url = article.imageURL{
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                article.imageData = data
                DispatchQueue.main.async {
                    cell.newsImage.image = UIImage(data: data)
                }
            }.resume()
        }
        
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped(_:)), for: .touchUpInside)
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        if let url = article.url {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else {
            print("URL для данной новости отсутствует")
        }
    }
    
    @objc func bookmarkButtonTapped(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else {
            return
        }
        print(indexPath, " index path!!")
        
        let article = articles[indexPath.row]
        
        if BookmarkManager.contains(article) {
            if let index = BookmarkManager.bookmarks.firstIndex(of: article) {
                BookmarkManager.bookmarks.remove(at: index)
            }
        } else {
            BookmarkManager.bookmarks.append(article)
        }
        
        refresh()
    }
    
    @objc func shareButtonTapped(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else {
            return
        }
        print(indexPath, " index path!!")
        let article = articles[indexPath.row]
        
        let activityViewController = UIActivityViewController(activityItems: [article.url ?? "https://www.apple.com/"], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}
