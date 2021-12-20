//
//  HSActivityIndicator.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/20.
//

import Foundation
import UIKit
import RxSwift


class HSActivityIndicator {
    
    public lazy var activityIndicator = ActivityIndicator()
    
    private weak var view : UIView?
    
    private let disposeBag = DisposeBag()
    
    init(view: UIView?) {
        self.view = view;
        
        self.activityIndicator.drive {[unowned self] loading in
            
            guard let view = self.view else {return}
            
            if loading {
                view.hs.hud(.loading)
            } else {
                view.hs.hud(.hidden)
            }
            
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: disposeBag)

    }
    
}
