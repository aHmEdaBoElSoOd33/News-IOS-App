//
//  NewsApi.swift
//  Sports News
//
//  Created by Ahmed on 30/12/2022.
//

import Foundation

protocol NewsDelegate {
    func didFetchData(posts:News)
}
  
class NewsApi {
    
    var delegate : NewsDelegate?
    
    
    func fetchData(url:String){
        let url = URL(string: url )
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url!) { data, response , error in
             
            do {
                
                let news : News = try JSONDecoder().decode(News.self, from: data!)
                self.delegate?.didFetchData(posts: news)
            }catch{
                print(error)
            }
            
            
        }
        task.resume()
    }
     
}
