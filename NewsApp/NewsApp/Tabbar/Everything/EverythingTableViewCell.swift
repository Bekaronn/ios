//
//  TopHeadlinesTableViewCell.swift
//  NewsApp
//
//  Created by Bekarys on 02.03.2024.
//

import UIKit

class ArticleViewModel : Equatable {
    static func == (lhs: ArticleViewModel, rhs: ArticleViewModel) -> Bool {
            return lhs.title == rhs.title &&
                lhs.description == rhs.description &&
                lhs.imageURL == rhs.imageURL &&
                lhs.imageData == rhs.imageData
        }
    
    let title: String
    let description: String
    let imageURL: URL?
    var imageData: Data?
    var url: URL?
    var isBookmarked: Bool = false
    
    init(
        title: String,
        description: String,
        imageURL: URL?,
        url: URL?
    ) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.url = url
    }
}

class EverythingTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
