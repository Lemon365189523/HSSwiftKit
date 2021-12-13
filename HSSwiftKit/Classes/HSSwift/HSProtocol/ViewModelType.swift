//
//  ViewModelType.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/12.
//

import Foundation
import RxCocoa
import RxSwift

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

public protocol RefreshActionType {
    var onRefresh: Driver<Void> {get set}
    var onLoadMore: Driver<Void> {get set}
}

public protocol RefreshType {
    var isRefreshing: PublishSubject<Bool> {get set}
    var isNotMoreData: PublishSubject<Bool> {get set}
}

public protocol EmptyDataType {
    var empty: PublishSubject<HSEmptyViewType>{get set}
}



