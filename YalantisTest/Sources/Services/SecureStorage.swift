//
//  SecureStorage.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 21.11.2021.
//

import Foundation
import KeychainSwift
import RxSwift

protocol SecureStorageProtocol {
    func saveValue(of value: String, with key: String)
    
    func loadValue(with key: String)
    
    func resetValue(with key: String)
    
    var observable: Observable<ManagedKeychainValue> { get }
}

class SecureStorage: SecureStorageProtocol {
    let keychain = KeychainSwift()
    
    private let observableSubject = BehaviorSubject<ManagedKeychainValue>(value: ManagedKeychainValue(value: ""))
    
    var observable: Observable<ManagedKeychainValue> {
        return observableSubject.asObservable()
    }
    
    func saveValue(of value: String, with key: String) {
        keychain.set(value, forKey: key)
        loadValue(with: key)
        
    }
    
    func loadValue(with key: String) {
        
        if let loadedString = self.keychain.get(key) {
            observableSubject.onNext(ManagedKeychainValue(value: loadedString))
        } else {
            observableSubject.onNext(ManagedKeychainValue(value: "0"))
        }
    }
    
    func resetValue(with key: String) {
        keychain.set("0", forKey: key)
        loadValue(with: key)
    }
}
