//
//  UICollectionView+DelegateModel.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/13.
//

import Foundation
import ObjectiveC
import HSBase
import UIKit
import HSKit

// 嵌套结构体
private struct AssociatedKeys {
    static var waterFallDelegateModel = "UICollectionView_WaterFall_DelegateModel"
    static var defaultDelegateModel = "UICollectionView_Default_DelegateModel"
    static var dataArray = "UICollectionView_DataArray"
    static var isWaterFall = "UICollectionView_isWaterFall"
    static var modelSelected = "UICollectionView_ModelSelected"
}

extension HS where Base: UICollectionView {
    
    /// 是否是流式布局
    public var isWaterFall: Bool {
        get {
            return objc_getAssociatedObject(base, &AssociatedKeys.isWaterFall) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(base, &AssociatedKeys.isWaterFall, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    public var delegateModel: HSCollectCommonDelegateModel {
        if self.isWaterFall {
            return self.waterFallDelegateModel
        } else {
            return self.defaultDelegateModel
        }
    }
    
    private var waterFallDelegateModel: HSSimpleWaterFallDelegateModel {
        get {
            if let model = objc_getAssociatedObject(base, &AssociatedKeys.waterFallDelegateModel) as? HSSimpleWaterFallDelegateModel {
                return model
            }else {
                let model = HSSimpleWaterFallDelegateModel.init(dataArr: self.dataArray, collectionView: base) {[weak base] idx, cellModel in
                    guard let base = base else {return}
                    if base.hs.modelSeleced != nil {
                        base.hs.modelSeleced!(idx, cellModel)
                    }
                }
                objc_setAssociatedObject(base, &AssociatedKeys.waterFallDelegateModel, model, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                // 把defaultDelegateModel置空
                objc_setAssociatedObject(base, &AssociatedKeys.defaultDelegateModel, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return model
            }
        }
    }
    
    private var defaultDelegateModel: HSSimpleCollectCommonDelegateModel {
        get {
            if let model = objc_getAssociatedObject(base, &AssociatedKeys.defaultDelegateModel) as? HSSimpleCollectCommonDelegateModel {
                return model
            }else {
                let model = HSSimpleCollectCommonDelegateModel.init(dataArr: self.dataArray, collectionView: base) {[weak base] idx, cellModel in
                    guard let base = base else {return}
                    if base.hs.modelSeleced != nil {
                        base.hs.modelSeleced!(idx, cellModel)
                    }
                }
                objc_setAssociatedObject(base, &AssociatedKeys.defaultDelegateModel, model, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                // 把waterFallDelegateModel 置空
                objc_setAssociatedObject(base, &AssociatedKeys.waterFallDelegateModel, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
    
    public var modelSeleced: ((IndexPath?, Any?) -> ())? {
        get {
            return objc_getAssociatedObject(base, &AssociatedKeys.modelSelected) as? ((IndexPath?, Any?) -> ())
        }
        set {
            objc_setAssociatedObject(base, &AssociatedKeys.modelSelected, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置数据
    /// - Parameter datas: 分组模型数组
    public func reloadData(_ datas: [HSTableAndCollectCommonGroupModel]){
        base.hs.dataArray.removeAllObjects()
        base.hs.dataArray.addObjects(from: datas)
        base.reloadData()
    }
    
    /// 设置delegate
    /// - Parameter isWaterFall: 是否是流式布局
    public mutating func setting(_ isWaterFall: Bool){
        self.isWaterFall = isWaterFall;
        _ = self.delegateModel
    }
    
}
