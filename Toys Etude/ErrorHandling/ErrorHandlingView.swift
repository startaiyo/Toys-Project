//
//  ErrorHandlingView.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2024/06/07.
//

import SwiftUI

struct ErrorHandlingView: View {
    @State var text = ""
    let data = Data(stringData: .init(text: "this is data"))
    let data2 = Data(enumData: EnumValueData(rawValue: "aaa"))
    let dataArray = [Data(enumData: EnumValueData(rawValue: "a")),
                     Data(enumData: EnumValueData(rawValue: "aaa")),
                     Data(enumData: EnumValueData(rawValue: "b"))]
    var currentValue: String = "-1"
    var positiveIntValue: Int {
        get throws {
            return try getPositiveInt(from: currentValue)
        }
    }

    var body: some View {
        Text(text).onAppear {
            text = getValue()
//            print(IntValueData(string: "4")?.data)
//            print(IntValueData(string: "hoge")?.data)
//            print(data.stringData?.text)
//            print(EnumValueData(rawValue: "a"))
//            print(EnumValueData(rawValue: "c"))
//            print(dataArray.map { $0.enumData })
//            print(dataArray.compactMap { $0.enumData })
//            var value: Int?
//            do {
//                value = try positiveIntValue
//            } catch let error as GetPositiveIntError {
//                print(error.message)
//            } catch {
//                print("unknown error occurred")
//            }

            print("not rethrow")
            executeGetStrings(for: 7) {
                print(try getStringRandomly())
            }

//            print("rethrow")
//            do {
//                try executeGetStringsThrows(for: 7) {
//                    print(try getStringRandomly())
//                }
//            } catch {
//                fatalError("fail!!")
//            }

            try! executeGetStringsThrows(for: 7) {
                print(try getStringRandomly())
            }

            executeGetStringsThrows(for: 7) {
                print(getValue())
            }
        }
    }
}

func executeGetStrings(for times: Int,
                       execution: () throws -> Void) {
    for _ in 0..<times {
        do {
            try execution()
        } catch {
            print("failed to get string")
        }
    }
}

func executeGetStringsThrows(for times: Int,
                             execution: () throws -> Void) rethrows {
    for _ in 0..<times {
        try execution()
    }
}

func getStringRandomly() throws -> String {
    if Bool.random() {
        return "someValue"
    } else {
        throw GetStringError.fail
    }
}

enum GetStringError: Error {
    case fail
}

func getPositiveInt(from string: String) throws -> Int {
    if let intValue = Int(string) {
        if intValue >= 0 {
            return intValue
        }
        throw GetPositiveIntError.negativeIntError
    } else {
        throw GetPositiveIntError.notNumberError
    }
}

enum GetPositiveIntError: Error {
    case negativeIntError
    case notNumberError

    var message: String {
        switch self {
            case .negativeIntError:
                return "negative value detected"
            case .notNumberError:
                return "cannot convert to number"
        }
    }
}

func getValue(isSuccess: Bool = true) -> String? {
    return isSuccess ? "value" : nil
}

func getValue() -> String {
    return ""
}

enum EnumData: String {
    case a
    case b
}

class Data {
    var stringData: StringValueData?
    var enumData: EnumValueData?

    init(stringData: StringValueData? = nil,
         enumData: EnumValueData? = nil) {
        self.stringData = stringData
        self.enumData = enumData
    }
}

class StringValueData {
    var text: String?

    init(text: String? = nil) {
        self.text = text
    }
}

class EnumValueData {
    let data: EnumData

    init?(rawValue: String) {
        guard let data = EnumData(rawValue: rawValue) else {
            return nil
        }
        self.data = data
    }
}

class IntValueData {
    var data: Int

    init?(string: String) {
        guard let data = Int(string) else {
            return nil
        }
        self.data = data
    }
}
