//
//  UI+Rx.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/12.
//

import Foundation
import RxCocoa
import RxSwift
//import HSCategorys

//MARK: --UIScrollView
extension Reactive where Base : UIScrollView {
    
    public var onRefresh : Driver<Void> {
        return Observable<Void>.create {[weak base] (observer) -> Disposable in
            if let base = base {
//                base.jy.onRefresh {
//                    observer.onNext(())
//                }
            }
            return Disposables.create()
        }.asDriverOnErrorJustComplete()
    }
    
    public var onLoadMore : Driver<Void> {
        return Observable<Void>.create {[weak base] (observer) -> Disposable in
            if let base = base {
//                base.jy.onLoadMore {
//                    observer.onNext(())
//                }
            }
            return Disposables.create()
        }.asDriverOnErrorJustComplete()
    }
    
    public var isRefreshing : Binder<Bool> {
        return Binder(self.base) { scrollView, isRefreshing in
            if isRefreshing {
//                scrollView.jy.startRefresh()
            }else {
//                scrollView.jy.stopRefresh()
            }
        }
    }
    
    public var isNoMoreData : Binder<Bool> {
        return Binder(self.base) { scrollView, isNoMore in
//            scrollView.jy.stopLoadMore(isNoMore)
        }
    }
}

//MARK: --UIImageView
extension Reactive where Base : UIImageView {
    public var imageUrl : Binder<(String)> {
        return Binder(self.base) { imageView, urlString in
//            imageView.setImage(urlString: urlString, placeholder: nil)
            imageView.hs_sdImage(withUrlString: urlString)
        }
    }
    
//    public var imageUrlAndplaceholder : Binder<(urlString: String, placeholder: String)> {
//        return Binder(self.base) { imageView, value in
//            imageView.setImage(urlString: value.urlString, placeholder: value.placeholder)
//        }
//    }
}
