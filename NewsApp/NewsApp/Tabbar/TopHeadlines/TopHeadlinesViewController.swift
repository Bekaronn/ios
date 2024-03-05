//
//  TopHeadlinesViewController.swift
//  NewsApp
//
//  Created by Bekarys on 02.03.2024.
//

import UIKit
import SafariServices

class TopHeadlinesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    private var articles: [ArticleViewModel] = []
    private var count_refresh = 0
    private var timer: Timer?
    private var isTimerRunning = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchTopHeadlines()
        startTimer()
    }
    
    private func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(fetchTopHeadlines), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        if isTimerRunning {
            stopTimer()
            stopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            print("refresh is stopped")
        } else {
            startTimer()
            stopButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            print("refresh is started")
        }
        isTimerRunning.toggle()
    }
    
    @IBAction func goToSettings(_ sender: UIButton) {
        performSegue(withIdentifier: "showSettingsViewController", sender: self)
    }
    
    @objc private func fetchTopHeadlines() {
        APIManager.shared.getTopHeadlines { [weak self] result in
            switch result {
            case .success(let articles):
                print("\(articles.count) articles")
                self?.count_refresh += 1
                let count = self?.count_refresh ?? -1
                print("\(count) is refresh")
                
                self?.articles = articles.compactMap({
                    ArticleViewModel(
                        title: $0.title,
                        description: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? "https://thumbs.dreamstime.com/b/news-woodn-dice-depicting-letters-bundle-small-newspapers-leaning-left-dice-34802664.jpg"),
                        url: URL(string: $0.url ?? "https://www.apple.com/")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error", error)
            }
        }
    }
    
    deinit {
        stopTimer()
    }
    
}

extension TopHeadlinesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        APIManager.qTopHeadlines = "&q=\(text)"
        searchBar.resignFirstResponder()
        fetchTopHeadlines()
    }
}

extension TopHeadlinesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(articles.count)
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopHeadlinesTableViewCell
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
        
        cell.shareButton.addTarget(self, action: #selector(shareButtonTapped(_:)), for: .touchUpInside)
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
        
        tableView.reloadRows(at: [indexPath], with: .none)
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
