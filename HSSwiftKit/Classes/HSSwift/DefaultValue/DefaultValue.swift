//
//  DefaultValue.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/4.
//

import Foundation

protocol DefaultValue {
    associatedtype Value: Codable
    static var defaultValue: Value { get }
}


@propertyWrapper
struct Default<T: DefaultValue> {
    var wrappedValue: T.Value
}

extension Default: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }
}

// 解决解析Key缺失
extension KeyedDecodingContainer {
    func decode<T>(_ type: Default<T>.Type,forKey key: Key) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
    }
}

extension Bool {
    enum False: DefaultValue {
        static let defaultValue = false
    }
    enum True: DefaultValue {
        static let defaultValue = true
    }
}

extension Int: DefaultValue{
    static let defaultValue = 0
    
    enum Ten: DefaultValue {
        static let defaultValue = 10
    }
}

extension Double: DefaultValue{
    static let defaultValue = 0
    
    enum Ten: DefaultValue {
        static let defaultValue = 10
    }
}

extension String: DefaultValue{
    static let defaultValue = ""
    
    enum Empty: DefaultValue {
        static let defaultValue = ""
    }
}

extension Array: DefaultValue where Element: Codable  {
    static var defaultValue: Array<Element> { [] }
}

extension Default {
    typealias False = Default<Bool.False>
    typealias True = Default<Bool.True>
    typealias TenInt = Default<Int.Ten>
    typealias TenDouble = Default<Int.Ten>
    typealias EmptyString = Default<String.Empty>
}

/// 使用方式
struct Model {
    @Default.False var falseValue: Bool
    @Default.True var trueValue: Bool
    @Default.TenInt var tenValue: Int
    @Default<Int> var intValue: Int
}
