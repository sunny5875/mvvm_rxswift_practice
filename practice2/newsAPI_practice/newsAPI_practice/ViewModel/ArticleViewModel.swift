//
//  ArticleViewModel.swift
//  newsAPI_practice
//
//  Created by 현수빈 on 2022/08/03.
//

import Foundation

protocol ArticleViewModelType {
    var article : Article { get }
    var title: String? {get}
    var description: String? {get}
    
    var imageUrl : String? {get}
}

class ArticleViewModel {
    private let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
    
    var title: String? {
        return self.article.title
    }
    var description: String? {
        return self.article.description
    }
    
    var imageUrl : String? {
        return self.article.urlToImage
    }
}
