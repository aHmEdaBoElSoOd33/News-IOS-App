//
//  SportsNewsVC.swift
//  Sports News
//
//  Created by Ahmed on 30/12/2022.
//

import UIKit

class NewsVC: UIViewController {
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
 
    
    //MARK: - Variables
    
    var url = ""
    var postNum = 10
    var categoryTag : Int?
    var newsArray = [Article(title: "" , url: "", urlToImage: "")]
    var postsArray : [Article] = [Article(title: "", url: "", urlToImage: "")]
    var newsApi = NewsApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Apisetup()
        tableView.delegate=self
        tableView.dataSource=self
        newsApi.delegate=self
        print(categoryTag!)
        
    }
    

    //MARK: - Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! WebsiteVC
        let selectedRow = tableView.indexPathForSelectedRow?.row
        vc.websitURL = postsArray[selectedRow!].url
    }
      
    func Apisetup() {
        
        switch categoryTag {
        case 0:
            url = "https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=8b37d8a3b30d497fab3c2ba52ad231fa"
            postNum = 5
            newsApi.fetchData(url: url)
        case 1:
            url = "https://newsapi.org/v2/top-headlines?country=eg&category=entertainment&apiKey=8b37d8a3b30d497fab3c2ba52ad231fa"
            newsApi.fetchData(url: url)
            
        case 2:
            url = "https://newsapi.org/v2/top-headlines?country=eg&category=health&apiKey=8b37d8a3b30d497fab3c2ba52ad231fa"
            newsApi.fetchData(url: url)
        case 3:
            url = "https://newsapi.org/v2/top-headlines?country=eg&category=science&apiKey=8b37d8a3b30d497fab3c2ba52ad231fa"
            newsApi.fetchData(url: url)
            
        case 4:
            url = "https://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=8b37d8a3b30d497fab3c2ba52ad231fa"
            newsApi.fetchData(url: url)
        case 5:
            url = "https://newsapi.org/v2/top-headlines?country=eg&category=technology&apiKey=8b37d8a3b30d497fab3c2ba52ad231fa"
            newsApi.fetchData(url: url)
        default:
            url = "https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=8b37d8a3b30d497fab3c2ba52ad231fa"
            newsApi.fetchData(url: url)
        }
    }
}

  

    //MARK: - Extintions

extension NewsVC : UITableViewDelegate,UITableViewDataSource{
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

extension NewsVC : NewsDelegate{
    func didFetchData(posts: News) {
        newsArray=posts.articles
        postsArray.removeAll()
        
        for i in 0...postNum{
            postsArray.append(newsArray[i])
            }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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


 
