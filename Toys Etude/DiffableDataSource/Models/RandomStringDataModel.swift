//
//  RandomStringDataModel.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2023/12/09.
//

struct RandomStringDataModel: Codable {
    let data: [RandomStringModel]
}

struct RandomStringModel: Codable {
    let string: String
}
