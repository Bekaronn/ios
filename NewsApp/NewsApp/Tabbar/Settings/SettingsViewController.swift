//
//  SettingsViewController.swift
//  NewsApp
//
//  Created by Bekarys on 03.03.2024.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var selectCategoryButton: UIButton!
    @IBOutlet var categoryButtons: [UIButton]!
    
    @IBOutlet weak var selectCountryButton: UIButton!
    @IBOutlet var countryButtons: [UIButton]!
    
    @IBOutlet weak var selectPageSizeButton: UIButton!
    @IBOutlet var pageSizeButtons: [UIButton]!
    
    @IBOutlet weak var selectSortByButton: UIButton!
    @IBOutlet var sortByButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showCategoryButtonVisibility(){
        categoryButtons.forEach { button in
            UIView.animate(withDuration: 0.3){
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func selectCategoryAction(_ sender: Any){
        showCategoryButtonVisibility()
    }
    
    @IBAction func categoryButtonAction(_ sender: UIButton){
        showCategoryButtonVisibility()
        switch sender.currentTitle {
        case "Business":
            APIManager.category = "&category=business"
            print("Business")
        case "Science":
            APIManager.category = "&category=science"
            print("Science")
        case "Sports":
            APIManager.category = "&category=sports"
            print("Sports")
        default:
            print("no")
        }
    }
    
    func showCountryButtonVisibility(){
        countryButtons.forEach { button in
            UIView.animate(withDuration: 0.3){
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func selectCountryAction(_ sender: Any){
        showCountryButtonVisibility()
    }
    
    @IBAction func countryButtonAction(_ sender: UIButton){
        showCountryButtonVisibility()
        switch sender.currentTitle {
        case "US":
            print("us")
            APIManager.country = "&country=us"
        case "FR":
            print("fr")
            APIManager.country = "&country=fr"
        case "RU":
            print("ru")
            APIManager.country = "&country=ru"
        default:
            print("no")
        }
    }
    
    func showPageSizeButtonVisibility(){
        pageSizeButtons.forEach { button in
            UIView.animate(withDuration: 0.3){
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func selectPageSizeAction(_ sender: Any){
        showPageSizeButtonVisibility()
    }
    
    @IBAction func pageSizeButtonAction(_ sender: UIButton){
        showPageSizeButtonVisibility()
        switch sender.currentTitle {
        case "15":
            APIManager.pageSize = "&pageSize=15"
            print("15")
        case "30":
            APIManager.pageSize = "&pageSize=30"
            print("30")
        case "100":
            APIManager.pageSize = "&pageSize=100"
            print("100")
        default:
            print("no")
        }
    }
    
    func showSortByButtonVisibility(){
        sortByButtons.forEach { button in
            UIView.animate(withDuration: 0.3){
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func selectSortByAction(_ sender: Any){
        showSortByButtonVisibility()
    }
    
    @IBAction func sortByButtonAction(_ sender: UIButton){
        showSortByButtonVisibility()
        switch sender.currentTitle {
        case "publishedAt":
            APIManager.sortBy = "&sortBy=publishedAt"
            print("publishedAt")
        case "relevancy":
            APIManager.sortBy = "&sortBy=relevancy"
            print("relevancy")
        case "popularity":
            APIManager.sortBy = "&sortBy=popularity"
            print("popularity")
        default:
            print("no")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
