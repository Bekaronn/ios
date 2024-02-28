import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBoard = UIStoryboard(name: "Tabbar", bundle: nil)
        if let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "Tabbar") as? UITabBarController {
            self.navigationController?.pushViewController(tabBarVC, animated: false)
        }
    }
}
