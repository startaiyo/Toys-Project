//
//  AccessControlViewModel.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2024/05/11.
//

import SecretModule

internal final class AccessControlViewModel {
    private(set) var privateSetResult = "This is private!"
    internal var internalResult = "internal"

    func changeResult() {
        privateSetResult = "altered"
    }

    func changeResultFromFileprivate() {
        privateSetResult = SecretClass().secretFileprivate
//        privateSetResult = SecretClass().secretPrivate
    }

    func changeResultFromAnotherModule() {
        privateSetResult = SecretModuleClass().secretModuleValue
    }

    func changeResultFromInheritedClassFromModule() {
        privateSetResult = SecretClass().secretModuleValue
    }
}

final class SecretClass: SecretModuleClass {
    private let secretPrivate = "private"
    fileprivate let secretFileprivate = "fileprivate"

    override init() {
        super.init()
        self.secretModuleValue = "overridden secret"
    }
}
