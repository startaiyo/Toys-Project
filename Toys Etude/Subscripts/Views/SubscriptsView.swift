//
//  SubscriptsView.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2024/05/20.
//

import SwiftUI

struct SubscriptsView: View {
    var apple = Fruit(weight: 100,
                      name: "Apple",
                      detail: ["prefecture": "Aomori",
                               "color": "green"],
                      producer: Producer(name: "aaa",
                                         age: 60), 
                      price: Price(yen: 150,
                                   dollar: 1))
    let age = \Fruit.producer.age
    let name = \Fruit.producer.name
    var body: some View {
        Text(apple["name"])
        Text(apple["color"])
            .onAppear {
                apple["color"] = "red"
            }
        Text(apple.prefecture)
        Text(Fruit.taste)
        Text("\(apple[keyPath: name]): \(apple[keyPath: age])")
            .onAppear {
                apple[keyPath: name] = "fuga"
            }
        Text("\(apple.hoge)")
        Text("\(apple.yen)")
    }
}

@dynamicMemberLookup
class Fruit {
    let id = UUID().uuidString
    let weight: Int
    var name: String
    var detail: [String: String]
    let producer: Producer
    let price: Price

    init(weight: Int, 
         name: String,
         detail: [String : String],
         producer: Producer,
         price: Price) {
        self.weight = weight
        self.name = name
        self.detail = detail
        self.producer = producer
        self.price = price
    }

    subscript(key: String) -> String {
        get {
            switch key {
                case "weight": 
                    return "\(weight)"
                case "name": 
                    return name
                default: 
                    return detail[key] ?? ""
            }
        }
        set(newValue) {
            switch key {
                case "name":
                    name = newValue
                default:
                    detail[key] = newValue
            }
        }
    }

    subscript(dynamicMember key: String) -> String {
        return detail[key] ?? ""
    }

    subscript<T>(dynamicMember keyPath: KeyPath<Price, T>) -> String {
        return "\(price[keyPath: keyPath])"
    }

    class subscript(dynamicMember key: String) -> String {
        switch key {
            case "taste": return "sweet"
            default: return ""
        }
    }
}

class Producer {
    var name: String
    let age: Int

    init(name: String, 
         age: Int) {
        self.name = name
        self.age = age
    }
}

struct Price {
    let yen, dollar: Int
    let hoge: String = "aaa"
}
