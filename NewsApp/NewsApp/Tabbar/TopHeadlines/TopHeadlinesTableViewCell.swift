//
//  TopHeadlinesTableViewCell.swift
//  NewsApp
//
//  Created by Bekarys on 02.03.2024.
//

import UIKit

class TopHeadlinesTableViewCellViewModel {
    let title: String
    let description: String
    let imageURL: URL?
    var imageData: Data?
    
    init(
        title: String,
        description: String,
        imageURL: URL?
    ) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
}

class TopHeadlinesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
