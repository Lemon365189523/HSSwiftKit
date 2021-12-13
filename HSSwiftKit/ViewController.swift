//
//  ViewController.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/4.
//

import UIKit
import SnapKit
import HSCommon
import RxSwift
import RxCocoa
import HSBase

class ViewController: UIViewController {
    
    lazy var collectionView: UITableView = {
//        let layout = UICollectionViewFlowLayout()
//        let c = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        let tb = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tb.hs.reloadData([]);
        return tb
    }()
    
    lazy var viewModel = TestViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSubviews()
        bindViewModel()
    }
    
    func setupSubviews() {
        view.addSubview(self.collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bindViewModel(){
        let output = viewModel.transform(input: TestViewModel.Input(onRefresh: collectionView.rx.onRefresh, onLoadMore: collectionView.rx.onLoadMore))
        
        output.isRefreshing.drive(collectionView.rx.isRefreshing).disposed(by: rx.disposeBag)
        
        output.list.drive(onNext: {[weak self] list in
            guard let self = self else { return }
            self.collectionView.hs.reloadData(list)
        }).disposed(by: rx.disposeBag)
        
    }
    
    
}



class TestViewModel: NSObject, ViewModelType, ListDataType {
    
    var list: BehaviorRelay<[HSTableAndCollectCommonGroupModel]> = BehaviorRelay.init(value: [])
    
    var pageSize: Int = 10
    
    var pageIndex: Int = 1
    
    
    struct Input: RefreshActionType {
        var onRefresh: Driver<Void>
        
        var onLoadMore: Driver<Void>
        
    }
    
    struct Output: RefreshType {
        var isRefreshing: Driver<Bool>
        
        var isNotMoreData: Driver<Bool>
        
        var list: Driver<[HSTableAndCollectCommonGroupModel]>
    }
    
    func transform(input: Input) -> Output {
        let isRefreshing: PublishSubject<Bool> = PublishSubject<Bool>()
        
        let isNotMoreData: PublishSubject<Bool> = PublishSubject<Bool>()
        
        input.onRefresh.asObservable().flatMap { _ in
            HSNetManager.rx.request(TestApi.categorys, modelType: [CategoryItem].self)
                .catch({ error in
                    return Observable.empty()
                })
        }.subscribe(onNext: {[weak self] datas in
            isRefreshing.onNext(false)
            guard let self = self, let itemList = datas else { return }
            print(itemList)
            let grouModel = HSTableAndCollectCommonGroupModel()
            grouModel.itemsArray.addObjects(from: itemList.map({ item in
                let cellModel = CategoryCellModel()
                
                return cellModel
            }))
            self.list.accept([grouModel])
        }, onError: {error in
            print(error)
            isRefreshing.onNext(false)
        }).disposed(by: self.rx.disposeBag)
        
        return Output(isRefreshing: isRefreshing.asDriverOnErrorJustComplete(),
                      isNotMoreData: isNotMoreData.asDriverOnErrorJustComplete(),
                      list: list.asDriver())
    }
    
}

struct CategoryItem: Codable {
    @Default.EmptyString var parentId: String
    @Default.EmptyString var id: String
    @Default.EmptyString var icon: String
    @Default<[CategoryItem]> var CategoryItem: [CategoryItem]
}

//@objcMembers
class CategoryCellModel: HSTableAndCollectBaseItemModel {
    override var itemCellClassName: String! {
        get {
            return "UITableViewCell"
        }
        set {}
    }
}


enum TestApi {
    case categorys
}

extension TestApi: ApiType {
    var url: String {
        switch self {
        case .categorys:
            return Host.url("/app/product/category/list")
        }
    }
    
    var parameters: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    var method: HSRequestMethod {
        return .GET
    }
    
    
}
