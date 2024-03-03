//
//  TopHeadlinesViewController.swift
//  NewsApp
//
//  Created by Bekarys on 02.03.2024.
//

import UIKit

class TopHeadlinesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var stopButton: UIButton!
    
    
    private var articles: [TopHeadlinesTableViewCellViewModel] = []
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
    
    @objc private func fetchTopHeadlines() {
        APIManager.shared.getTopHeadlines { [weak self] result in
            switch result {
            case .success(let articles):
                print("\(articles.count) articles")
                self?.count_refresh += 1
                let count = self?.count_refresh ?? -1
                print("\(count) is refresh")
                
                self?.articles = articles.compactMap({
                    TopHeadlinesTableViewCellViewModel(
                        title: $0.title,
                        description: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? "https://thumbs.dreamstime.com/b/news-woodn-dice-depicting-letters-bundle-small-newspapers-leaning-left-dice-34802664.jpg")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error")
            }
        }
    }
    
    deinit {
        stopTimer()
    }
    
}

extension TopHeadlinesViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        <#code#>
//    }
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
        
        return cell
    }
    
}
