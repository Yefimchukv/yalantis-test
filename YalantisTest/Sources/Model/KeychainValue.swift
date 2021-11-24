//
//  KeychainValue.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 22.11.2021.
//

import Foundation

// MARK: - ManagedKeychainValue
struct ManagedKeychainValue {
    let value: String
}

extension ManagedKeychainValue {
    func toKeychainValue() -> KeychainValue {
        return KeychainValue(value: Int(self.value))
    }
}

// MARK: - KeychainValue
struct KeychainValue {
    let value: Int?
}

extension KeychainValue {
    func toPresentableKeychainValue() -> PresentableKeychainValue {
        guard let value = self.value else {
            return PresentableKeychainValue(value: "N/A")
        }
        return PresentableKeychainValue(value: String(value))
    }
}

// MARK: - PresentableKeychainValue
struct PresentableKeychainValue {
    let value: String
}
