//
//  CategoriesVC.swift
//  NewsApp
//
//  Created by Ahmed on 31/12/2022.
//

import UIKit

class CategoriesVC: UIViewController {
    //MARK: - IBOutlets
     
    @IBOutlet weak var categorieBtn: UIButton!
    
    //MARK: - Variables
    
    var newsTitle : String?
    
    
    var tags : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    
    //MARK: - IBActions
    
    @IBAction func catgoryBtn(_ sender: Any) {
        //performSegue(withIdentifier: "gotoNews", sender: self)
        tags = (sender as AnyObject).tag
        print(tags)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsVC") as! NewsVC
        vc.categoryTag = tags
        navigationController?.pushViewController(vc, animated: true)
        switch tags {
        case 0 :
            newsTitle = "Business"
        case 1 :
            newsTitle = "Entertainment"
        case 2 :
            newsTitle = "Health"
        case 3 :
            newsTitle = "Science"
        case 4 :
            newsTitle = "Sports"
        case 5 :
            newsTitle = "Technology"
        default:
            newsTitle = "Business"
        }
        
        vc.navigationItem.title = newsTitle
        
    }

}
