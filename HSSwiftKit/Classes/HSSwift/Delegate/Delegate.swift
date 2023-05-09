//
//  Delegate.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/15.
//

import Foundation

public class Delegate<Input, Output> {
    private var block: ((Input) -> (Output?))?
    
    func delegate<T: AnyObject>(on target: T, block:((T, Input) -> Output)?) {
        self.block = { [weak target] input in
            guard let target = target else {
                return nil
            }
            return block?(target, input)
        }
    }
    ///Swift 5.2 中引入的 callAsFunction，它可以让我们直接以“调用实例”的方式 call 一个方法。使用起来很简单，只需要创建一个名称为 callAsFunction 的实例方法就可以了：
    func callAsFunction(_ input: Input) -> Output? {
        return call(input)
    }
    
    private func call(_ input: Input) -> Output? {
        return block?(input)
    }
}


/**
 let onReturnOptional = Delegate<Int, Int?>()
 let value = onReturnOptional(1)
 //value: Int?? 双层可选值
 要解决这个问题，可以对 Delegate 进行扩展，为那些 Output 是 Optional 情况提供重载的 call(_:) 实现。
 */

public protocol OptionalProtocol {
    static var createNil: Self { get }
}

extension Optional : OptionalProtocol {
    public static var createNil: Optional<Wrapped> {
         return nil
    }
}

extension Delegate where Output: OptionalProtocol {
    public func call(_ input: Input) -> Output? {
        if let result = block?(input) {
            return result
        } else {
            return .createNil
        }
    }
}

// 使用例子
//let onReturnOptional = Delegate<Int, Void>()
//let value = onReturnOptional.call(1)
//
//onReturnOptional.delegate(on: self) { weakSelf, value in
//
//}
