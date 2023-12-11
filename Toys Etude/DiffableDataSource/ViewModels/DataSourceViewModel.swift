//
//  DataSourceViewModel.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2023/12/09.
//

import Foundation

protocol DataSourceViewModelOutput {
    var items: [RandomStringModel] { get }
    var itemIdentifiers: [ItemIdentifier] { get }
    func reload(completion: @escaping () -> Void)
}

protocol DataSourceViewModelInput {
    func deleteData(for index: Int,
                    completion: @escaping () -> Void)
}
typealias DataSourceViewModelProtocol = DataSourceViewModelOutput & DataSourceViewModelInput

final class DataSourceViewModel {
    private var randomStringData: [RandomStringModel]?
    private var randomStringItemIdentifier: [ItemIdentifier]?

    init() {
        getData()
    }
}

private extension DataSourceViewModel {
    func getData() {
        Task {
            do {
                let url = URL(string: "http://localhost:8000/v1/random")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let randomData = try JSONDecoder().decode(RandomStringDataModel.self,
                                                          from: data)
                randomStringData = randomData.data
            } catch {
                print(error)
            }
        }
    }
}

extension DataSourceViewModel: DataSourceViewModelOutput {
    var items: [RandomStringModel] { randomStringData ?? [] }
    var itemIdentifiers: [ItemIdentifier] { randomStringItemIdentifier ?? []}
    func reload(completion: @escaping () -> Void) {
        Task {
            do {
                let url = URL(string: "http://localhost:8000/v1/random")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let randomData = try JSONDecoder().decode(RandomStringDataModel.self,
                                                          from: data)
                randomStringData = randomData.data
                randomStringItemIdentifier = randomData.data.map { .init(viewModel: .init(text: $0.string)) }
                completion()
            } catch {
                print(error)
            }
        }
    }
}

extension DataSourceViewModel: DataSourceViewModelInput {
    func deleteData(for index: Int,
                    completion: @escaping () -> Void) {
        if var randomStringData {
            randomStringData.remove(at: index)
            self.randomStringData = randomStringData
            self.randomStringItemIdentifier = randomStringData.map { .init(viewModel: .init(text: $0.string)) }
            completion()
        }
    }
}
