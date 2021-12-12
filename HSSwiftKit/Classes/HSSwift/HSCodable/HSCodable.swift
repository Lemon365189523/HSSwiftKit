//
//  HSCodable.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/4.
//

import Foundation

extension String: HSNameSpace{}
extension Data: HSNameSpace{}

extension HS where Base: Encodable {
    
    public func toString() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted
        do {
            let data = try encoder.encode(base)
            let str = String(data: data, encoding: .utf8)
            return str!
        } catch {
            debugPrint("\(self)转字符串失败,注意\(self)可能是可选类型")
            return ""
        }
    }
}

extension HS where Base == String {
    /// String转模型
    /// - Parameter type: 模型的类型，必须遵循Decodable
    public func toModel<T>(_ type: T.Type) -> T? where T : Decodable{
        
        if let data: Data = base.data(using: .utf8) {
            return data.hs.toModel(type)
        }else {
           return decodeFail(type)
        }
    }
    
    /// String转模型
    /// - Parameter type: 模型的类型，必须遵循Decodable
    public func toModelArray<T>(_ type: T.Type) -> [T]? where T : Decodable{
        
        return toModel([T].self)
    }
}


extension HS where Base == Data {
    
    /// jsonData转模型
    /// - Parameter type: 模型的类型，必须遵循Decodable
    public func toModel<T>(_ type: T.Type) -> T? where T : Decodable{
        
        if let model: Decodable = try? JSONDecoder().decode(T.self, from: base){
            
            return model as? T
        }else {
            
            return decodeFail(type)
        }
    }
}

fileprivate extension HS {
    ///json 解析失败debug提示
    func decodeFail<T>(_ type: T.Type) -> T? where T : Decodable {
        print("json字符串序列化 \(type) 失败")
        var errorStr: String = ""
        if let db = base as? Data{
            errorStr = String(data: db, encoding: .utf8) ?? ""
        }else if let str = base as? String {
            errorStr = str
        }
        print("""
            原字符串：
            \(errorStr)
            """)
        return nil
    }
}
