//
//  File.swift
//  newsAPI_practice
//
//  Created by νμλΉ on 2022/08/03.
//

import Foundation

struct ArticleList : Decodable {
    var articles : Array<Article>
}
struct Article : Decodable {
    let title : String?
    let urlToImage : String?
    let description : String?
    
   
   
}
