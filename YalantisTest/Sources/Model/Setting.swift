//
//  Setting.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 19.10.2021.
//

import Foundation

// MARK: - ManagedSetting
struct ManagedSetting {
    let name: String
    let defaultsKey: String
    let hasSwitch: Bool
}

extension ManagedSetting {
    func toSetting() -> Setting {
        return Setting(name: self.name, defaultsKey: self.defaultsKey, hasSwitch: self.hasSwitch)
    }
}

// MARK: - Setting
struct Setting {
    let name: String
    let defaultsKey: String
    let hasSwitch: Bool
}

extension Setting {
    func toPresentableSetting() -> PresentableSetting {
        return PresentableSetting(name: self.name, defaultsKey: self.defaultsKey, hasSwitch: self.hasSwitch)
    }
}

// MARK: - PresentableSetting
struct PresentableSetting {
    let name: String
    let defaultsKey: String
    let hasSwitch: Bool
}
