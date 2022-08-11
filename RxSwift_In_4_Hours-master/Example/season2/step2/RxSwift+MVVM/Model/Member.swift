//
//  Meber.swift
//  RxSwift+MVVM
//
//  Created by 현수빈 on 2022/08/03.
//  Copyright © 2022 iamchiwon. All rights reserved.
//

import Foundation

struct Member: Decodable {
    let id: Int
    let name: String
    let avatar: String
    let job: String
    let age: Int
}
