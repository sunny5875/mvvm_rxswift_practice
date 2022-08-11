//
//  ViewController.swift
//  RxSwiftIn4Hours
//
//  Created by iamchiwon on 21/12/2018.
//  Copyright © 2018 n.code. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    //subject
    let idValid : BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let pwValid : BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    let idInputText : BehaviorSubject<String> = BehaviorSubject(value: "")
    let pwInputText : BehaviorSubject<String> = BehaviorSubject(value: "")
    
    var viewModel : ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // bindUI1()
       // bindOuput()
        
       // bindUI2()
        
        bindUsingViewModel1()
    }

    // MARK: - IBOutler

    @IBOutlet var idField: UITextField!
    @IBOutlet var pwField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var idValidView: UIView!
    @IBOutlet var pwValidView: UIView!

    // MARK: - Bind UI

    private func bindUI1() {
        // id input +--> check valid --> bullet(red light)
        //          |
        //          +--> button enable
        //          |
        // pw input +--> check valid --> bullet(red light)
        
        
        //------1. 초기구현 -----//
        /*
        idField.rx.text
//            .filter{$0 != nil}
//            .map{$0!}
            .orEmpty //위의 두줄을 요약하여 string이 있거나 없거나로 판단 가능한 것!
            .map(checkEmailValid)
            .subscribe(onNext: {b in
                self.idValidView.isHidden = b
            }).disposed(by: disposeBag)
        
        
        pwField.rx.text.orEmpty
            .map(checkPasswordValid)
            .subscribe(onNext: { b in
                self.pwValidView.isHidden = b
            }).disposed(by: disposeBag)
        
        //Observable 중에서 하나만 바뀌더라도 둘 다 내려보내주는 데 가장 최근 것을 내려 보낼 수 있도록 하기 위해 combineLatest를 사용
        Observable.combineLatest(
            idField.rx.text.orEmpty.map(checkEmailValid(_:)),
            pwField.rx.text.orEmpty.map(checkPasswordValid),
            resultSelector: {s1,s2 in s1 && s2})
            .subscribe(onNext: {b in
                self.loginButton.isEnabled = b
            })
            .disposed(by: disposeBag)
        
        */
        
        //-----2. 리펙토링-----//
        //매번 subscribe하지 말고 필요한 시점에 subscribe해보자!!
        
        /*
        //input
        let idInputOb : Observable<String> = idField.rx.text.orEmpty.asObservable()
        let idValidOb = idInputOb.map(checkEmailValid(_:))

        
        let pwInputOb : Observable<String> = pwField.rx.text.orEmpty.asObservable()
        let pwValidOb = pwInputOb.map(checkPasswordValid(_:))
            
        
        //output
        idValidOb.subscribe(onNext : {b in
            self.idValidView.isHidden = b
        }).disposed(by: disposeBag)

        pwValidOb.subscribe(onNext : {b in
            self.pwValidView.isHidden = b
        }).disposed(by: disposeBag)

        Observable.combineLatest(idValidOb,
                                 pwValidOb,
                                 resultSelector: {s1,s2 in s1 && s2})
        .subscribe(onNext: {b in
            self.loginButton.isEnabled = b
        })
        .disposed(by: disposeBag)
        */
         
        //-----3.subject를 사용------//
        
        //input
//        let idInputOb : Observable<String> = idField.rx.text.orEmpty.asObservable()
//        idInputOb.map(checkEmailValid(_:)).subscribe(onNext: {b in
//            self.idValid.onNext(b)
//        })
        
//        idInputOb.map(checkEmailValid(_:)).bind(to: idValid).disposed(by: disposeBag)// 위의 문장과 동일, stream으로 받은 애를 밖에 있는 애로 보내주는 통로 역할
        
       /* idField.rx.text.orEmpty //optional을 없애주는 애이지 빈칸이라고 안오는 애가 아님
            .bind(to: idInputText) //idField의 값을 idInputText에 저장해줌
            .disposed(by: disposeBag)
        
        idInputText
            .map(checkEmailValid(_:))
            .bind(to: idValid) //valid의 유무를 idValid에 보내줌
            .disposed(by: disposeBag)
        
        pwField.rx.text.orEmpty
            .bind(to: pwInputText)//pwField의 값을 pwInputText에 저장해줌
            .disposed(by: disposeBag)
    
        
        pwInputText
            .map(checkPasswordValid(_:))
            .bind(to: pwValid)//valid의 유무를 idValid에 보내줌
            .disposed(by: disposeBag)*/
        
       
        
    }
    private func bindOuput(){
        
        //빈칸이 아니고 조건이 충족되지 않아야 show
        
//        idValid.subscribe(onNext : {b in
//            self.idValidView.isHidden = b
//        }).disposed(by: disposeBag)
//
//        pwValid.subscribe(onNext : {b in
//            self.pwValidView.isHidden = b
//        }).disposed(by: disposeBag)
        
//        idInputText.subscribe(onNext:{str in
//            self.idValidView.isHidden = str == "" ? true : false
//        }).disposed(by: disposeBag)
        
        
        
        
        Observable.combineLatest(idValid,
                                 pwValid,
                                 resultSelector: {s1,s2 in s1 && s2}).subscribe(onNext: {b in
            self.loginButton.isEnabled = b
        }).disposed(by: disposeBag)
        
        
        //---- 빈칸일 때에도 불빛이 꺼지도록 하기 위해 내가 작성한 코드 --- //
        //zip은 둘 다 바뀔 때 반응하는 거고 combineLatest는 하나라도 바뀔 때 반응을 하는 Operator
        Observable.combineLatest(idInputText, idValid,resultSelector: {s1,s2 in
            return (s1 == "") || s2})
            .subscribe(onNext : {b in
            self.idValidView.isHidden = b
        }).disposed(by: disposeBag)
        
        Observable.combineLatest(pwInputText, pwValid,resultSelector: {s1,s2 in
            return (s1 == "") || s2})
            .subscribe(onNext : {b in
            self.pwValidView.isHidden = b
        }).disposed(by: disposeBag)
        
    }
    
    //매우 간단하게 줄인 형태, subscribe 대신에 bind로 간단하게 표현
    /*
     func bindUI2(){
        
        let ob1 = idField.rx.text.orEmpty
            .map(checkEmailValid)
            .distinctUntilChanged()
        
        let ob2 = pwField.rx.text.orEmpty
            .map(checkPasswordValid)
        
            .distinctUntilChanged()
        ob1.bind(to: idValidView.rx.isHidden).disposed(by: disposeBag)
        ob2.bind(to: pwValidView.rx.isHidden).disposed(by: disposeBag)
        
        Observable.combineLatest(ob1,ob2){b1,b2 in b1 && b2}
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
    }*/
    
    /*
    func bindUsingViewModel(){
        //input 2 : 이메일, 비번 UI -> viewModel에 연결
        
        idField.rx.text.orEmpty.subscribe(onNext:{email in
            self.viewModel.setEmailText(email: email)
        }).disposed(by: disposeBag)
        
        
        pwField.rx.text.orEmpty.subscribe(onNext:{pw in
            self.viewModel.setPasswordText(pw: pw)
        }).disposed(by: disposeBag)
        
        //output 2 : 이메일, 비번의 유효 여부 ViewModel의 결과를 UI에 연결
        viewModel.isEmailValid
            .drive(idValidView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.isPasswordValid
            .drive(pwValidView.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        //output 1 : 버튼의 상태
        Driver.combineLatest(viewModel.isPasswordValid,viewModel.isEmailValid ){b1,b2 in b1 && b2}
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    
    }*/
    
    func bindUsingViewModel1(){
        
        let input = ViewModel.Input(email: idField.rx.text.orEmpty.asObservable(), pw: pwField.rx.text.orEmpty.asObservable())
        
        viewModel = ViewModel(input: input)
        
        let output = viewModel.calculateOutput(input: input)
        
        output.isEmailValid
            .drive(idValidView.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.isPasswordValid
            .drive(pwValidView.rx.isHidden)
            .disposed(by: disposeBag)
        
        //1.UI를 가지고 결정하는 거니까 viewController에 있어도 무방하여 여기서 결정하는 방법
//        Driver.combineLatest(output.isPasswordValid,output.isEmailValid ){b1,b2 in b1 && b2}
//            .drive(loginButton.rx.isEnabled)
//            .disposed(by: disposeBag)
        
        //2. viewModel에게 위임하는 방법
        output.isLoginValid
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

   
}
