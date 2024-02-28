import UIKit

class TopheadlinesTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Инициализация кода
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Настройка выбора ячейки
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
