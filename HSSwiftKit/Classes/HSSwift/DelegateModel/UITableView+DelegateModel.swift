//
//  UITableView+DelegateModel.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/13.
//

import Foundation
import ObjectiveC
import HSBase

// 嵌套结构体
private struct AssociatedKeys {
    static var delegateModel = "UITableView_DelegateModel"
    static var dataArray = "UITableView_DataArray"
    static var modelSelected = "UITableView_ModelSelected"
}

extension HS where Base: UITableView {
    
    public var delegateModel: HSSimpleTableDelegateModel {
        get {
            if let model = objc_getAssociatedObject(base, &AssociatedKeys.delegateModel) as? HSSimpleTableDelegateModel {
                return model
            }else {
                let model = HSSimpleTableDelegateModel.init(dataArr: base.hs.dataArray, tableView: base, useAutomaticDimension: true) {[weak base] ip, cellModel in
                    guard let base = base else {return}
                    if base.hs.modelSeleced != nil {
                        base.hs.modelSeleced!(ip, cellModel)
                    }
                }
                objc_setAssociatedObject(base, &AssociatedKeys.delegateModel, model, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return model
            }
        }
    }
    
    private var dataArray: NSMutableArray {
        get {
            if let array = objc_getAssociatedObject(base, &AssociatedKeys.dataArray) as? NSMutableArray {
                return array
            }else {
                let array = NSMutableArray()
                objc_setAssociatedObject(base, &AssociatedKeys.dataArray, array, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return array
            }
        }
    }
    
    public func reloadData(_ datas: [HSTableAndCollectCommonGroupModel]){
        if base.hs.dataArray.count == 0 && datas.count == 0 {
            _ = base.hs.delegateModel
            return
        }
        base.hs.dataArray.removeAllObjects()
        base.hs.dataArray.addObjects(from: datas)
        base.reloadData()
    }
    
    public var modelSeleced: ((IndexPath?, Any?) -> ())? {
        get {
            return objc_getAssociatedObject(base, &AssociatedKeys.modelSelected) as? ((IndexPath?, Any?) -> ())
        }
        set {
            objc_setAssociatedObject(base, &AssociatedKeys.modelSelected, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
