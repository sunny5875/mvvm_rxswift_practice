//
//  ViewModel.swift
//  RxSwiftIn4Hours
//
//  Created by 현수빈 on 2022/08/04.
//  Copyright © 2022 n.code. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
       
    var disposeBag: DisposeBag { get set }
       
    func calculateOutput(input: Input) -> Output
}


class ViewModel : ViewModelType {
    var disposeBag: DisposeBag = DisposeBag()
    
    
    // MARK: - Logic
    
    
    let input: Input
//    let output: Output

    
    struct Input {
        //input : 두개의 입력, observer
        let email : Observable<String>
        let pw : Observable<String>
    }
    
    struct Output {
        //output : 출력, obserable
        let isEmailValid : Driver<Bool>
        let isPasswordValid : Driver<Bool>
        let isLoginValid : Driver<Bool>
       
    }
    

    
    init(input : Input){
        self.input = input
        
    }
    
    func calculateOutput(input : Input) -> Output {
        //observer를 사용하기 위한 subject
        let emailSubject = BehaviorRelay(value: false)
        let pwSubject = BehaviorRelay(value: false)
        
        
       
        input.email.subscribe(onNext: {
            email in
            emailSubject.accept(self.checkEmailValid(email))
        }).disposed(by: disposeBag)
        
        input.pw.subscribe(onNext: {pw in
            pwSubject.accept(self.checkPasswordValid(pw))
        }).disposed(by: disposeBag)
        
        
        let loginDriver = Driver.combineLatest(emailSubject.asDriver(),pwSubject.asDriver() ){b1,b2 in b1 && b2}.asDriver()
        
        return Output(isEmailValid: emailSubject.asDriver(), isPasswordValid: pwSubject.asDriver(),isLoginValid: loginDriver)
    }
                            
                
 
    
    
    private func checkEmailValid(_ email: String) -> Bool {
//        return email.contains("@") && email.contains(".")
        return email.isEmpty || (email.contains("@") && email.contains("."))
    }

    private func checkPasswordValid(_ password: String) -> Bool {
//        return password.count > 5
        return password.isEmpty || password.count > 5
    }
}
