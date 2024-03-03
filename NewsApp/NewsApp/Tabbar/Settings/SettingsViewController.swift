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
        selectCategoryButton.setTitle(APIManager.category, for: .normal)
        selectPageSizeButton.setTitle(APIManager.pageSize, for: .normal)
        selectSortByButton.setTitle(APIManager.sortBy, for: .normal)
        selectCountryButton.setTitle(APIManager.country.uppercased(), for: .normal)
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
        case "business":
            APIManager.category = "business"
            selectCategoryButton.setTitle("business", for: .normal)
            print("Business")
        case "science":
            APIManager.category = "science"
            selectCategoryButton.setTitle("science", for: .normal)
            print("Science")
        case "sports":
            APIManager.category = "sports"
            selectCategoryButton.setTitle("sports", for: .normal)
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
            APIManager.country = "us"
            selectCountryButton.setTitle("US", for: .normal)
        case "FR":
            print("fr")
            APIManager.country = "fr"
            selectCountryButton.setTitle("FR", for: .normal)
        case "RU":
            print("ru")
            APIManager.country = "ru"
            selectCountryButton.setTitle("RU", for: .normal)
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
            APIManager.pageSize = "15"
            selectPageSizeButton.setTitle("15", for: .normal)
            print("15")
        case "30":
            APIManager.pageSize = "30"
            selectPageSizeButton.setTitle("30", for: .normal)
            print("30")
        case "100":
            APIManager.pageSize = "100"
            selectPageSizeButton.setTitle("100", for: .normal)
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
            APIManager.sortBy = "publishedAt"
            selectSortByButton.setTitle("publishedAt", for: .normal)
            print("publishedAt")
        case "relevancy":
            APIManager.sortBy = "relevancy"
            selectSortByButton.setTitle("relevancy", for: .normal)
            print("relevancy")
        case "popularity":
            APIManager.sortBy = "popularity"
            selectSortByButton.setTitle("popularity", for: .normal)
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
