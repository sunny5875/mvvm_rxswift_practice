//
//  GetSend.swift
//  newsAPI_practice
//
//  Created by 현수빈 on 2022/08/03.
//

import Foundation
import RxSwift

let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=e9b514c39c5f456db8ed4ecb693b0040"
class WebService {
    //원래 함수
    static func getArticles(completion: @escaping (Result<[Article],Error>) -> Void) {
        URLSession.shared.dataTask(with: URL(string: url)!) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error)) // if any error occurs, article can be nil
            }
            else if let data = data {
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                print(articleList!)
                if let articleList = articleList {
                    completion(.success(articleList.articles))
                }
                print(articleList?.articles)
                 
            }
            
        }.resume()
        
    }
    //rxSwift로 변경한 코드
    static func getArticlesRx() -> Observable<[Article]> {
        return Observable.create { emitter in
            getArticles() { result in
                switch result {
                case let .success(data):
                    print(data)
                    emitter.onNext(data)
                    emitter.onCompleted()
                case let .failure(error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
