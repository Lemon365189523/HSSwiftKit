//
//  Mediator.swift
//  HSSwiftKit
//
//  Created by fan on 2022/12/29.
//

import Foundation
import HSMediator

extension HSParameters: HSNameSpace {}

extension HS where Base: HSParameters {
    
    static func create(parameters: [AnyHashable : Any]) -> HSParameters {
        return HSParameters.parameters()(parameters)
    }
    
}

extension HSParameters {
    func key(_ key: String) -> HSParameters {
        self.key()(key)
        return self
    }
    
    func value(_ value: Any) -> HSParameters {
        self.value()(value)
        return self
    }
    
    func keyAndValue(key: String, value: Any) -> HSParameters {
        return self.key(key).value(value)
    }
    
    func valueForkey(_ key: String) -> Any? {
        return self.valueForKey()?(key)
    }
    
    func defaultCallBack(_ callBack: @escaping HSDefaultCallBack) -> HSParameters {
        return self.defaultCB()(callBack)
    }
    
    func valueCallBack(_ callBack: @escaping HSValueCallBack) -> HSParameters {
        return self.valueCB()(callBack)
    }
}

extension HSTargetAction {
    
    
}


//HSParameters.hs.create(parameters: [:]).key("sss").value("ssss")
