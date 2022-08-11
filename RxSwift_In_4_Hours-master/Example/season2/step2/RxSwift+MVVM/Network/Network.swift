//
//  Network.swift
//  RxSwift+MVVM
//
//  Created by 현수빈 on 2022/08/03.
//  Copyright © 2022 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


func loadImage(from url: String) -> Observable<UIImage?> {
    return Observable.create { emitter in
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
            if let error = error {
                emitter.onError(error)
                return
            }
            guard let data = data,
                let image = UIImage(data: data) else {
                emitter.onNext(nil)
                emitter.onCompleted()
                return
            }

            emitter.onNext(image)
            emitter.onCompleted()
        }
        task.resume()
        return Disposables.create {
            task.cancel()
        }
    }
}

func loadMembers() -> Observable<[Member]> {
    return Observable.create { emitter in
        let task = URLSession.shared.dataTask(with: URL(string: MEMBER_LIST_URL)!) { data, _, error in
            if let error = error {
                emitter.onError(error)
                return
            }
            guard let data = data,
                let members = try? JSONDecoder().decode([Member].self, from: data) else {
                emitter.onCompleted()
                return
            }

            emitter.onNext(members)
            emitter.onCompleted()
        }
        task.resume()
        return Disposables.create {
            task.cancel()
        }
    }
}
