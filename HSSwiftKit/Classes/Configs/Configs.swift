//
//  Configs.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/4.
//

import Foundation
import UIKit
import HSCommon

struct Screen {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

//基本常量
struct Configs {
    
    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        static let Tmp = NSTemporaryDirectory()
    }
    
    struct Dimensions {
        static let statusBarHeight = HS_STATUS_BAR_HEIGHT()
        static let inset: CGFloat = 10
        static let tabBarHeight: CGFloat = Device.isIphoneX ? 49 + 34 : 49
        static let navBarWithStatusBarHeight: CGFloat = statusBarHeight + navgationBarHeight
        static let navgationBarHeight: CGFloat = 44
        static let scale = Screen.width / Screen.height
        static let bottomHight : CGFloat = Device.isIphoneX ? 34 : 0
    }
    
    struct Device {
        static let isIphoneX = [812 , 896].contains(Screen.height)
        static let isLessThanIphon6 = Screen.width <= 375
    }
    
}

struct Host {
    static func url(_ path: String) -> String {
        let host: NSString = HSHost as NSString
        return host.appendingPathComponent(path)
    }
}
