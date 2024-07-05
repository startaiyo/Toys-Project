//
//  ResultBuilderView.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2024/05/27.
//

import SwiftUI

struct ResultBuilderView: View {
    private let langs = ["Ruby", "PHP", "Golang", "Swift"]
    @RichTextBuilder
    private var richText: NSAttributedString {
        for lang in langs {
            RichText(string: "We like ")
            if lang == "Swift" {
                RichText(string: lang)
                    .lined()
                Punctuations.period
            } else {
                RichText(string: lang)
                Punctuations.comma
            }
        }
    }
    private var richText2: NSAttributedString {
        let formerAttributeString = NSMutableAttributedString(string: "We like ")
        let latterAttributedString = NSMutableAttributedString(string: "swift")
        latterAttributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                            value: 1,
                                            range: .init(location: 0,
                                                         length: latterAttributedString.length))
        formerAttributeString.append(latterAttributedString)
        return formerAttributeString
    }

    var body: some View {
        Text(AttributedString(richText))
//        Text(AttributedString(richText2))
    }
}

typealias RichText = NSMutableAttributedString

@resultBuilder
enum RichTextBuilder {
    static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()

        for component in components {
            attributedString.append(component)
        }

        return attributedString
    }

    static func buildArray(_ components: [NSAttributedString]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()

        for component in components {
            attributedString.append(component)
        }

        return attributedString
    }

    static func buildEither(first component: NSAttributedString) -> NSAttributedString {
        return component
    }

    static func buildEither(second component: NSAttributedString) -> NSAttributedString {
        return component
    }

    static func buildExpression(_ expression: Punctuations) -> NSAttributedString {
        switch expression {
            case .period:
                return RichText(".\n")
            case .comma:
                return RichText(",\n")
        }
    }

    static func buildExpression(_ expression: NSMutableAttributedString) -> NSAttributedString {
        return expression
    }
}

enum Punctuations {
    case period
    case comma
}

private extension NSMutableAttributedString {
    func lined() -> NSMutableAttributedString {
        self.addAttribute(NSAttributedString.Key.underlineStyle,
                          value: 1,
                          range: .init(location: 0,
                                       length: self.length))
        return self
    }
}
