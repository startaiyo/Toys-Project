//
//  DecodableView.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2024/06/24.
//

import SwiftUI

struct DecodableView: View {
    let user = ConsumerModel(name: "Taro")

    var body: some View {
        Text("Decodable!")
            .onAppear {
                let data1 = PurchaseData(user: user,
                                         price: 200,
                                         item: "toy",
                                         count: 2)
                let data2 = PurchaseData(user: user,
                                         price: 200,
                                         item: "toy",
                                         count: 2,
                                         address: "Japan, Shinjuku")
                let encoder = JSONEncoder()
                if let json = try? encoder.encode(data1) {
                    print(String(data: json,
                                 encoding: .utf8))
                    let decoder = JSONDecoder()
                    print(try? decoder.decode(PurchaseData.self,
                                              from: json))
                }
                if let json2 = try? encoder.encode(data2) {
                    print(String(data: json2,
                                 encoding: .utf8))
                    let decoder = JSONDecoder()
                    print(try? decoder.decode(PurchaseData.self,
                                              from: json2))
                }
            }
    }
}

struct PurchaseData: Codable {
    let user: ConsumerModel
    let price: Int
    let item: String
    let count: Int
    let address: String?

    init(user: ConsumerModel, 
         price: Int,
         item: String,
         count: Int,
         address: String? = nil) {
        self.user = user
        self.price = price
        self.item = item
        self.count = count
        self.address = address
    }
//    enum CodingKeys: String, CodingKey {
//        case user = "consumer"
//        case price
//        case item
//        case count
//    }
    enum CodingKeys: String, CodingKey {
        case consumerName = "consumer_name"
        case price
        case item
        case count
        case address
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(price, forKey: .price)
        try container.encode(item, forKey: .item)
        try container.encode(count, forKey: .count)
        try container.encode(user.name, forKey: .consumerName)
//        try container.encode(address, forKey: .address)
        try container.encodeIfPresent(address, forKey: .address)
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        price = try values.decode(Int.self, forKey: .price)
        item = try values.decode(String.self, forKey: .item)
        count = try values.decode(Int.self, forKey: .count)
        user = ConsumerModel(name: try values.decode(String.self, forKey: .consumerName))
//        address = try values.decode(String?.self, forKey: .address)
        address = try values.decodeIfPresent(String.self,
                                             forKey: .address)
    }
}

struct ConsumerModel: Codable {
    let name: String

    init(name: String) {
        self.name = name
    }
}
