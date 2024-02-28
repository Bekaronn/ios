import UIKit

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
}

class TopHeadlinesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var articles: [Article] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getTopHeadlines()
    }
    
    func getTopHeadlines() {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=3738013b0fe84f2b8339b09f5b068900"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self.articles = result.articles
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopheadlinesTableViewCell
        let article = self.articles[indexPath.row]
        cell.configure(with: article.title)
        return cell
    }
}
