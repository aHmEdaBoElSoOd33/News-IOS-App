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
    
    
    func fetchData(){
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=8b37d8a3b30d497fab3c2ba52ad231fa")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url!) { data, response , error in
             
            do {
                
                let news : News = try JSONDecoder().decode(News.self, from: data!)
                self.delegate?.didFetchData(posts: news)
               // print(news.articles[0].title)
            }catch{
                print(error)
            }
            
            
        }
        task.resume()
    }
     
}
