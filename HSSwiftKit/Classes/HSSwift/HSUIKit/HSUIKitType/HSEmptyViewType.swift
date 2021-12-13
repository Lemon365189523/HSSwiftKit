//
//  HSEmpty.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/12.
//

import Foundation
import UIKit

public enum HSEmptyViewType {
    case networkError
    case suggest(icon:UIImage, message:String, suggest: String)
    case button(icon:UIImage, message:String, buttonTitle: String)
    case hidden
}

extension HS where Base: UIView {
    @discardableResult
    public func emptyView(type: HSEmptyViewType, frame: CGRect?, action: (() -> ())?) -> UIView? {
        switch type {
        case .networkError:
            return base.hs_showNetworkError(withFrame: frame ?? base.bounds, actionBlock: action)
        case .suggest(let icon, let message, let suggest):
            return base.hs_showEmpty(withIconImage: icon, message: message, suggestStr: suggest, frame: frame ?? base.bounds, actionBlock: action)
        case .button(let icon, let message, let buttonTitle):
            return base.hs_showEmpty(withIconImage: icon, message: message, btnTitle: buttonTitle, frame: frame ?? base.bounds, actionBlock: action)
        case .hidden:
            base.hs_hiddenEmpty()
            return nil
        }
    }
}
