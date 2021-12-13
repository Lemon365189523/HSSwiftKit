//
//  UI+Rx.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/12.
//

import Foundation
import RxCocoa
import RxSwift
//MARK: --UIScrollView
extension Reactive where Base : UIScrollView {
    
    public var onRefresh : Driver<Void> {
        return Observable<Void>.create {[weak base] (observer) -> Disposable in
            if let base = base {
                base.hs.onRefresh {
                    observer.onNext(())
                }
            }
            return Disposables.create()
        }.asDriverOnErrorJustComplete()
    }
    
    public var onLoadMore : Driver<Void> {
        return Observable<Void>.create {[weak base] (observer) -> Disposable in
            if let base = base {
                base.hs.onLoadMore {
                    observer.onNext(())
                }
            }
            return Disposables.create()
        }.asDriverOnErrorJustComplete()
    }
    
    public var isRefreshing : Binder<Bool> {
        return Binder(self.base) { scrollView, isRefreshing in
            if isRefreshing {
                scrollView.hs.startRefresh()
            }else {
                scrollView.hs.stopRefresh()
            }
        }
    }
    
    public var isNoMoreData : Binder<Bool> {
        return Binder(self.base) { scrollView, isNoMore in
            scrollView.hs.stopLoadMore(isNoMore)
        }
    }
}

//MARK: --UIImageView
extension Reactive where Base : UIImageView {
    public var imageUrl : Binder<(String)> {
        return Binder(self.base) { imageView, urlString in
            imageView.hs_sdImage(withUrlString: urlString)
        }
    }
    
    public var imageUrlAndplaceholder : Binder<(urlString: String, placeholder: UIImage)> {
        return Binder(self.base) { imageView, value in
            imageView.hs_sdImage(withUrlString: value.urlString, placeholderImage: value.placeholder)
        }
    }
}


extension Reactive where Base: UIView {
    
    public struct HSRxEmptyItem {
        let type: HSEmptyViewType
        let frame: CGRect?
        let observer: AnyObserver<Void>?
    }
    
    public var empty: Binder<HSRxEmptyItem>{
        return Binder(self.base) { view, item in
            view.hs.emptyView(type: item.type, frame: item.frame) {
                guard let observer = item.observer else {
                    return
                }
                observer.onNext(())
            }
        }
    }
    
    public var hud: Binder<HSHUDType> {
        return Binder(self.base) { view, type in
            view.hs.hud(type)
        }
    }
}

