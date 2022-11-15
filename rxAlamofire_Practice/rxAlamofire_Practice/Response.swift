//
//  Response.swift
//  rxAlamofire_Practice
//
//  Created by 현수빈 on 2022/11/15.
//

import Foundation

struct Response<T: Codable> : Codable {
    let success : Int
    let status: Int
    let data: T?
    let msg: String
}
