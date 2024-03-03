//
//  SettingsViewController.swift
//  NewsApp
//
//  Created by Bekarys on 03.03.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //TopHeadliens
    private var country = "&country=us"
    private var category = "&category=business"
    
    //Everything
    private var language = "&language=en"
    private var sortBy = "&sortBy=publishedAt"
    
    //PageSize&Page
    private var pageSize = "&pageSize=15"

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
