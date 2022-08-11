//
//  ViewController.swift
//  RxSwiftIn4Hours
//
//  Created by iamchiwon on 21/12/2018.
//  Copyright © 2018 n.code. All rights reserved.
//

import RxSwift
import UIKit

class ViewController: UITableViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func exJust1() {
//        Observable.just("Hello World")
//            .subscribe(onNext: { str in
//                print(str)// helloword가 바로 들어감
//            })
//            .disposed(by: disposeBag)
        
//        Observable.just("hello World")
//            .subscribe()//실행만 하고 결과는 필요 없다면 이렇게만 해도 됨
        
//        Observable.just("hello World")
//            .subscribe{event in
//                switch event{
//                case .next(let str):
//                    break
//                case .error(let err):
//                    break
//                case .completed:
//                    break
//                }
//            }.disposed(by: disposeBag)
        
        
    }

    @IBAction func exJust2() {
        Observable.just(["Hello", "World"]) // 배열을 넣으면 그냥 배열이 나옴, 넣은 거 그대로 나옴
            .subscribe(onNext: { arr in
                print(arr)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exFrom1() {
        Observable.from(["RxSwift", "In", 4, "Hours"])// 배열에 있는 걸 하나씩 보여줌
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
         
        Observable.from(["RxSwift", "In", 4, "Hours"])// 배열에 있는 걸 하나씩 보여줌
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exMap1() {
        Observable.just("Hello")
            .map { str in "\(str) RxSwift" }//위에서 hello가 내려왔는데 map으로 rxswift를 붙여서 내려가짐
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exMap2() {
        Observable.from(["with", "곰튀김"])
            .map { $0.count }//from이니까 하나씩 내려가는데 각각의 요소의 count가 내려가게 됨 : 줄 세워서 순서대로 내려가면서 거쳐가면서 지나가는 것을 stream이라고 함
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exFilter() {
        Observable.from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
            .filter { $0 % 2 == 0 } // stream으로 내려온 애들이 filter를 거치는데 짝수인 애들만 내려가짐
            .subscribe(onNext: { n in
                print(n)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exMap3() {
        Observable.just("800x600")
            .map { $0.replacingOccurrences(of: "x", with: "/") } // 800/600
            .map { "https://picsum.photos/\($0)/?random" } //url String로 변경
            .map { URL(string: $0) }// URL 구조체로 바뀜
            .filter { $0 != nil } //URL이 올바르다면
            .map { $0! } //강제 casting
            .map { try Data(contentsOf: $0) }//URL에 있는 Data를 다운받은 Data
            .map { UIImage(data: $0) } //그 데이터로 이미지를 보여줌
            .subscribe(onNext: { image in
                self.imageView.image = image //그걸 imageView에 세팅
            })
            .disposed(by: disposeBag)
    }
}
