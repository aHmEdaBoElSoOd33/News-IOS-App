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
    
    var newsArray =  [Article(title: "", description: "", url: "", urlToImage: "")]
    var newsApi = NewsApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsApi.fetchData()
        tableView.delegate=self
        tableView.dataSource=self
        newsApi.delegate=self
    }
}


    //MARK: - Extintions

extension SportsNewsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsCell
        cell.NewsTitle.text = newsArray[indexPath.row].title
       
        
            cell.NewsPoster.loadFrom(URLAddress: newsArray[indexPath.row].urlToImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension SportsNewsVC : NewsDelegate{
    func didFetchData(posts: News) {
        newsArray=posts.articles
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
        print(posts.articles[0].url)
    }
}



extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self.image = loadedImage
                }
            }
        }
    }
}
