//
//  HS.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/4.
//

import Foundation


public protocol HSNameSpace {
    associatedtype T
    var hs: T {get}
    static var hs: T.Type {get}
}

public struct HS<Base> {
    let base: Base
    init(base: Base) {
        self.base = base
    }
}

public extension HSNameSpace {
    var hs: HS<Self> {
        return HS<Self>(base: self)
    }
    
    static var hs: HS<Self>.Type {
        return HS<Self>.self
    }
}


