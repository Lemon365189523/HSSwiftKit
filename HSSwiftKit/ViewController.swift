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

class ViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let c = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        return c
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
        
        output.isRefreshing.bind(to: collectionView.rx.isRefreshing).disposed(by: rx.disposeBag)
        
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
        var isRefreshing: PublishSubject<Bool>
        
        var isNotMoreData: PublishSubject<Bool>
        
    }
    
    func transform(input: Input) -> Output {
        let isRefreshing: PublishSubject<Bool> = PublishSubject<Bool>()
        
        let isNotMoreData: PublishSubject<Bool> = PublishSubject<Bool>()
        
        input.onRefresh.asObservable().flatMap { _ in
            HSNetManager.rx.request(TestApi.categorys, modelType: [CategoryItem].self)
        }.subscribe(onNext: {[weak self] list in
            isRefreshing.onNext(false)
            guard let self = self, let itemList = list else { return }
            print(itemList)
            let grouModel = HSTableAndCollectCommonGroupModel()
            self.list.accept([grouModel])
        }, onError: {error in
            print(error)
            isRefreshing.onNext(false)
        }).disposed(by: self.rx.disposeBag)
        
        return Output(isRefreshing: isRefreshing, isNotMoreData: isNotMoreData)
    }
    
}

struct CategoryItem: Codable {
    @Default.EmptyString var parentId: String
    @Default.EmptyString var id: String
    @Default.EmptyString var icon: String
    @Default<[CategoryItem]> var CategoryItem: [CategoryItem]
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
