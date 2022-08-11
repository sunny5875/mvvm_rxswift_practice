//
//  ArticleListViewModel.swift
//  newsAPI_practice
//
//  Created by 현수빈 on 2022/08/03.
//

import Foundation
import RxSwift
import RxCocoa

protocol ArticleListViewModelType {
    var getArticles : BehaviorRelay<[Article]> {get}
    
    var errorMessage: Observable<NSError> { get }
    var articles: Driver<[Article]> { get }
    
    
//    var numberOfSections: Int {get}
//    func numberOfRowsInSection(_ section: Int) -> Int
//    func articleAtIndex(_ index: Int) -> ArticleViewModel
}



class ArticleListViewModel : ArticleListViewModelType {
   
    
    let disposeBag = DisposeBag()

    // INPUT
    let getArticles: BehaviorRelay<[Article]>

    // OUTPUT
    let errorMessage: Observable<NSError>
    let articles: Driver<[Article]>
  

    init() {
        //input : 기사를 넣을 빈 배열
        let fetching = BehaviorRelay<[Article]>(value: [])
       
        //output : 기사가 담겨진 배열과 에러 메세지
        let result = BehaviorRelay<[Article]>(value: [])
        let error = PublishSubject<Error>()

  
        //input
        getArticles = fetching

        WebService.getArticlesRx()
            .do(onError: { err in error.onNext(err) })
            .subscribe(onNext: result.accept)
            .disposed(by: disposeBag)


      
        // OUTPUT
        articles = result.asDriver()
        errorMessage = error.map { $0 as NSError }

       
    }
    
//    var numberOfSections: Int {
//        return 1
//    }
//
//    func numberOfRowsInSection(_ section: Int) -> Int {
//        return increaseArticleCount.inc
//    }
//
//    func articleAtIndex(_ index: Int) -> ArticleViewModel {
//        let article = self.articles[index]
//        return ArticleViewModel(article)
//    }
}
