//
//  HSRefreshType.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/13.
//

import Foundation
import HSUIComponents

public enum HSRefreshType {
    case white
    case gray
}

extension HS where Base: UIScrollView {
    public func onRefresh(_ type: HSRefreshType = .gray, _ action: @escaping ()->()) {
        switch type {
        case .white:
            base.mj_header = HSRefreshWhiteHeader(refreshingBlock: action)
        case .gray:
            base.mj_header = HSRefreshGrayHeader(refreshingBlock: action)
        }
    }
    
    public func onLoadMore(_ action: @escaping ()->()) {
        base.mj_footer = HSRefreshAutoFooter(refreshingBlock: action)
    }
    
    public func startRefresh() {
        base.mj_header?.beginRefreshing()
        base.mj_footer?.resetNoMoreData()
    }
    
    public func stopRefresh() {
        base.mj_header?.endRefreshing()
        base.hs.stopLoadMore(false)
    }
    
    public func stopLoadMore(_ isNotMore: Bool) {
        if isNotMore {
            base.mj_footer?.endRefreshingWithNoMoreData()
        } else {
            base.mj_footer?.endRefreshing()
        }
    }
    
}
