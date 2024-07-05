//
//  MemoryManagementView.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2024/07/01.
//

import SwiftUI

struct MemoryManagementView: View {
    var body: some View {
        Text("Memory Management")
            .onAppear {
                let author = Author(name: "Bob")
                let book = Book(name: "toy story",
                                author: author)
                print(book.warning())
            }
    }
}

class Book {
    var name: String
    unowned let author: Author
    lazy var warning: () -> String = { [weak self] in
        guard let self else { return "" }
        return "please contact \(self.author.name) if you're trouble with understanding \(self.name)"
    }

    init(name: String, author: Author) {
        self.name = name
        self.author = author
    }

    deinit {
        print("Book \(name) deinit")
    }
}

class Author {
    let name: String
    var books: [Book] = []

    init(name: String) {
        self.name = name
    }

    deinit {
        print("Author \(name) deinit")
    }
}
