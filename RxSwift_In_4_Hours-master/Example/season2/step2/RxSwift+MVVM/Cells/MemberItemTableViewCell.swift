//
//  MemberItemTableViewCell.swift
//  RxSwift+MVVM
//
//  Created by 현수빈 on 2022/08/03.
//  Copyright © 2022 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MemberItemCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var job: UILabel!
    @IBOutlet weak var age: UILabel!
    
    
    var disposeBag = DisposeBag()
    let onData: AnyObserver<Member>
    var element : Member?
    
    
    required init?(coder aDecoder: NSCoder) {
        
        let data = PublishSubject<Member>()
     
        onData = data.asObserver()

        super.init(coder: aDecoder)
        
        data.observeOn(MainScheduler.instance)
            .subscribe(onNext:{ element in
                self.setData(element)
                self.element = element
        }).disposed(by: disposeBag)
    }
    
    
    func setData(_ data: Member) {
        loadImage(from: data.avatar)
            .observeOn(MainScheduler.instance)
//            .bind(to: avatar.rx.image)
            .subscribe(onNext:{image in
                self.avatar.image = image
            })
            .disposed(by: disposeBag)
        
        avatar.image = nil
        name.text = data.name
        job.text = data.job
        age.text = "(\(data.age))"
    }

   

   
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

