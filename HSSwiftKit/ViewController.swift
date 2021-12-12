//
//  ViewController.swift
//  HSSwiftKit
//
//  Created by fan on 2021/12/4.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}





class TestViewModel: ViewModelType {
    struct Input  {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
    
}
