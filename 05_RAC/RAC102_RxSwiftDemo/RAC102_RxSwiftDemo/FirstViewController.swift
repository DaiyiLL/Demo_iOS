//
//  ViewController.swift
//  RAC102_RxSwiftDemo
//
//  Created by Daiyi on 2021/3/12.
//

import UIKit
import RxSwift


class FirstViewController: UIViewController {
    
    private lazy var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let numberSquence = Observable.just(5)
        numberSquence.subscribe(onNext: { [weak self](value) in
            print(value)
        }).disposed(by: self.disposeBag)
    }


}

