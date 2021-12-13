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

// 嵌套结构体
private struct AssociatedKeys {
    static var delegateModel = "UICollectionView_DelegateModel"
    static var dataArray = "UICollectionView_DataArray"
}

//extension HS where Base: UICollectionView {
//    
//    var delegateModel: HSSimpleWaterFallDelegateModel {
//        get {
//            if let model = objc_getAssociatedObject(base, &AssociatedKeys.delegateModel) as? HSSimpleTableDelegateModel {
//                return model
//            }else {
//                let model = HSSimpleTableDelegateModel.init(dataArr: base.hs.dataArray, tableView: base, useAutomaticDimension: true) { ip, cellModel in
//                    
//                }
//                objc_setAssociatedObject(base, &AssociatedKeys.delegateModel, model, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//                return model
//            }
//        }
//    }
//    
//    private var dataArray: NSMutableArray {
//        get {
//            if let array = objc_getAssociatedObject(base, &AssociatedKeys.dataArray) as? NSMutableArray {
//                return array
//            }else {
//                let array = NSMutableArray()
//                objc_setAssociatedObject(base, &AssociatedKeys.dataArray, array, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//                return array
//            }
//        }
//    }
//    
//    public func reloadData(_ datas: [HSTableAndCollectCommonGroupModel]){
//        base.hs.dataArray.removeAllObjects()
//        base.hs.dataArray.addObjects(from: datas)
//        base.reloadData()
//    }
//    
//}
