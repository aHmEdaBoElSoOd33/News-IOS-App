//
//  News.swift
//  Sports News
//
//  Created by Ahmed on 30/12/2022.
//

import Foundation

struct News : Decodable {
    var articles : [Article]
}

struct Article : Decodable {
    var title : String 
    var url : String?
    var urlToImage : String?
}
