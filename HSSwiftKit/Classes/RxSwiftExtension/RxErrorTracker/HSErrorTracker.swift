//
//  HSErrorTracker.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/20.
//

import Foundation
import UIKit
import RxSwift
import HSNetwork

class HSErrorTracker {
    
    public lazy var errorTracker = ErrorTracker()
    
    private weak var view: UIView?
    
    private let disposeBag = DisposeBag()
    
    init(view: UIView) {
        self.view = view
        
        self.errorTracker.drive(onNext: {[weak self] error in
            guard let self = self, let view = self.view else { return }
            let err = error as NSError
            view.hs.hud(.message(message: err.errorMsg, image: UIImage()))
        }).disposed(by: disposeBag)
        
    }
    
    
    
}
