//
//  Network+Rx.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/13.
//

import Foundation
import RxSwift
import RxCocoa
import HSNetwork

extension Reactive where Base: HSNetManager {
    
    public static func request<T>(_ api: ApiType, modelType:T.Type, progressHandle:((Progress)->())? = nil) -> Observable<T?> where T: Codable{
        return Observable.create { observer in
            let task = HSPublicNetManager.hs.request(api) { progress in
                if let progressHandle = progressHandle {
                    progressHandle(progress)
                }
            } success: { resp in
                if let data = resp.data as? Data {
                    let model = data.hs.toModel(modelType)
                    observer.onNext(model)
                    observer.onCompleted()
                }else if let data = resp.data as? String {
                    let model = data.hs.toModel(modelType)
                    observer.onNext(model)
                    observer.onCompleted()
                }else {
                    let data = try? JSONSerialization.data(withJSONObject: resp.data, options: [])
                    let model = data?.hs.toModel(modelType)
                    observer.onNext(model)
                    observer.onCompleted()
                }
            } fail: { error in
                observer.onError(error)
            }
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
}
