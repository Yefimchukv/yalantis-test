//
//  SecureStorage.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 21.11.2021.
//

import Foundation
import KeychainSwift

protocol SecureStorageProtocol {
    func saveValue(of value: String, with key: String)
    
    func loadValue(with key: String) -> ManagedKeychainValue
    
    func resetValue(with key: String)
}

class SecureStorage: SecureStorageProtocol {
    let keychain = KeychainSwift()
    
    func saveValue(of value: String, with key: String) {
        keychain.set(value, forKey: key)
    }
    
    func loadValue(with key: String) -> ManagedKeychainValue {
        guard let loadedString = keychain.get(key) else {
            
            // happens in case of loadnig failure or inital launch
            return ManagedKeychainValue(value: "0")
        }
        
        return ManagedKeychainValue(value: loadedString)
    }
    
    func resetValue(with key: String) {
        keychain.set("0", forKey: key)
    }
}
