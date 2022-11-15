//
//  Model.swift
//  rxAlamofire_Practice
//
//  Created by 현수빈 on 2022/11/15.
//
import Foundation
import RxSwift
import RxAlamofire
import RxCocoa


class CheckEmailNetwork  {
    static let shared: CheckEmailNetwork = CheckEmailNetwork()
    
    private var disposeBag: DisposeBag = DisposeBag()
    
    func checkEmailExist(_ username: String) -> BehaviorRelay<Bool> {
        let resultRelay = BehaviorRelay(value: false)
        
        let url = "http://218.39.132.7:4000/checkUMSUserEmailExists?email_address=sunny5875@naver.com"
        
        RxAlamofire.request(.get, url)
            .responseData()
            .subscribe(onNext: { res, data in
                do {
                    let result = try JSONDecoder().decode(Response<Bool>.self, from: data )
                    print(result)
                    resultRelay.accept(result.data ?? false)
                } catch(let error) {
                    print(error.localizedDescription)
                    resultRelay.accept(false)
                }

            }).disposed(by: disposeBag)
        
        
       return resultRelay
    }
    
   
}

