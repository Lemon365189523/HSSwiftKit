//
//  HSHUD.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/12.
//

import Foundation
import UIKit
import HSUIComponents


public enum HSHUDType {
    case loading
    case message(message: String, image: UIImage)
    case success(message: String)
    case fail(message: String)
    case hidden
}

extension HS where Base: UIView {
    
    public func hud(_ type: HSHUDType) {
        switch type {
        case .loading:
            MBManager.showHUD(in: base)
        case .message(let message, let image):
            MBManager.showHUD(withMessage: message, image: image)
        case .success(let message):
            MBManager.showSuccessHUD(withMessage: message,in: base)
        case .fail(let message):
            MBManager.showFailHUD(withMessage: message, in: base)
        case .hidden:
            MBManager.hiddenHUDinview(base)
        }
    }
}
