//
//  CustomOperatorView.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2024/05/16.
//

import SwiftUI

struct CustomOperatorView: View {
    private let initialValue = 2
    @State var currentValue = 2

    var body: some View {
//        Text("\(initialValue ** 2)")
//        Text("\(initialValue ** 8)")
//        Text("\(1.0%)")
        Button("exponent") {
            currentValue **= 2
        }
        Text("\(currentValue)")
        Text("\(currentValue * 2 ** 3 ** 2)")
    }
}

precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator **: ExponentiationPrecedence
infix operator **=
postfix operator %

postfix func %(num: Float) -> Float {
    return num / 100
}

func **<T: BinaryInteger>(base: T, power: Int) -> T {
    precondition(power >= 2)
    var result = base
    for _ in 2...power {
        result *= base
    }
    return result
}

func **=<T: BinaryInteger>(lhs: inout T, rhs: Int) {
    lhs = lhs ** rhs
}
