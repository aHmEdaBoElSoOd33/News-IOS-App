//
//  SportsNewsVC.swift
//  Sports News
//
//  Created by Ahmed on 30/12/2022.
//

import UIKit

class SportsNewsVC: UIViewController {
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
 
    
    //MARK: - Variables
    
    var newsArray = [Article(title: "" , url: "", urlToImage: "")]
    var postsArray : [Article] = [Article(title: "", url: "", urlToImage: "")]
    var newsApi = NewsApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsApi.fetchData()
        tableView.delegate=self
        tableView.dataSource=self
        newsApi.delegate=self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! WebsiteVC
        let selectedRow = tableView.indexPathForSelectedRow?.row
        vc.websitURL = postsArray[selectedRow!].url
        
    }
}
    //MARK: - Extintions
extension SportsNewsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsCell
        cell.cellContent.layer.backgroundColor = UIColor.white.cgColor
        cell.cellContent.layer.borderWidth = 0.1
        cell.NewsPoster.layer.borderWidth = 0.5
        cell.NewsPoster.layer.cornerRadius = 15
        cell.cellContent.layer.cornerRadius = 15
        cell.cellContent.layer.shadowColor = UIColor.black.cgColor
        cell.cellContent.layer.shadowOpacity = 0.5
        cell.cellContent.layer.shadowOffset = .zero
        cell.cellContent.layer.shadowRadius = 4
        cell.selectionStyle = .none
            cell.NewsTitle.text = postsArray[indexPath.row].title
            
            if postsArray[indexPath.row].urlToImage == nil{
                cell.NewsPoster.image = UIImage(named: "BK")
            }else{
                cell.NewsPoster.loadFrom(URLAddress: postsArray[indexPath.row].urlToImage!)
            }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoSite", sender: self)
    }
     
}

extension SportsNewsVC : NewsDelegate{
    func didFetchData(posts: News) {
        newsArray=posts.articles
        postsArray.removeAll()
        
        for i in 0...10{
            postsArray.append(newsArray[i])
            }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       // print(posts.articles[1].url)
    }
}



extension UIImageView  {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        DispatchQueue.global(qos: .background).async {
            [weak self] in
            guard let self = self else {
                return
            }
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.image = loadedImage
                    }
                }
            }
        }

    }
}


 
