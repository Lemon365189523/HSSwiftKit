//
//  Network.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/4.
//

import Foundation
import HSNetwork

public protocol ApiType {
    /// 请求url
    var url: String {get}
    /// 请求参数
    var parameters: [String: Any] {get}
    
    var headers: [String: String] {get}
    
    var method: HSRequestMethod {get}
}

extension HSNetManager: HSNameSpace {}

public extension HS where Base == HSNetManager {
    
    static func request(_ api: ApiType,
                        progress: ((Progress) -> ())?,
                        success:@escaping (_ resp: HSResponse) -> (),
                        fail:@escaping (_ error: Error) -> ()) -> URLSessionDataTask {
        
        let config = HSRequestConfig()
        config.method = api.method
        config.urlPath = api.url
        config.headers = api.headers
        config.parameters = api.parameters
        
        let task = HSPublicNetManager.shareInstance().request(with: config) { (pg) in
            if let progressBlock = progress {
                progressBlock(pg)
            }
        } success: { (resp) in
            success(resp)
        } failure: { (error) in
            fail(error)
        }
        return task
    }
    
}

 
