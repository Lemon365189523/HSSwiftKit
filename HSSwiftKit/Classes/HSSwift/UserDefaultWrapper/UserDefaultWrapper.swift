//
//  UserDefaultWrapper.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/4.
//

import Foundation

@propertyWrapper
struct UserDefaultWrapper<T> {
    let key: String
    let defaultValue: T?
    
    init(_ key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T? {
        get {
            UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: key)
            }else {
                UserDefaults.standard.setValue(newValue, forKey: key)
            }
            UserDefaults.standard.synchronize()
        }
    }
}

/**
// 使用方式
struct Model {
    @UserDefaultWrapper("model_name", defaultValue: "name")
    var name: String?
}
*/


