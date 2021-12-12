//
//  ViewModelType.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/12.
//

import Foundation
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

public protocol ListDataType {
    associatedtype Item
    var list : BehaviorRelay<[Item]> {get set}
    var pageSize : Int {get set}
    var pageIndex : Int {get set}
}


public protocol RefreshType {
    
}

public protocol EmptyDataType {
    
}
