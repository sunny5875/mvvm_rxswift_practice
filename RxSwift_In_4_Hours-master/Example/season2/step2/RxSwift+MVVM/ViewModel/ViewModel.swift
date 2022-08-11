//
//  ViewModel.swift
//  RxSwift+MVVM
//
//  Created by 현수빈 on 2022/08/03.
//  Copyright © 2022 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    //input : 감지하는 애니까 relay(subject)
    var inputMembers: BehaviorRelay<[Member]> {get}
    
    
    //output : 값이 바뀌는 애니까 observable(driver)
    var memberList : Driver<[Member]>{get}
//    var showDetail: Observable<Member> { get }
}


class ViewModel : ViewModelType {
    let disposeBag = DisposeBag()
    
    
    let inputMembers: BehaviorRelay<[Member]>
    
    let memberList : Driver<[Member]>
//    let showDetail: Observable<Member>
    
    init() {
        
        //input
        let fetching = BehaviorRelay<[Member]>(value: [])
        
        //output
        let result = BehaviorRelay<[Member]>(value: [])
        
        inputMembers = fetching
        
        loadMembers().subscribe(onNext: result.accept).disposed(by: disposeBag)
        
        memberList = result.asDriver(onErrorJustReturn: [])
        

    }
    
    
    
    
  
}
