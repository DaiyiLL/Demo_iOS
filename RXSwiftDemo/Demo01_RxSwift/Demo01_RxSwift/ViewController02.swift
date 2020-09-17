//
//  ViewController02.swift
//  Demo01_RxSwift
//
//  Created by yidai on 2019/8/7.
//  Copyright © 2019 daishuyi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController02: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let observable: Observable<String> = Observable<String>.of("A", "B", "C")
        
//        observable.subscribe { (event) in
//            print(event)
//        }
        
//        observable.subscribe(onNext: { (element) in
//            print(element)
//        }, onError: { (error) in
//            print(error)
//        }, onCompleted: {
//            print("completed")
//        }) {
//            print("disposed")
//        }
//        observable.subscribe(onNext: { element in
//            print(element)
//        }).disposed(by: DisposeBag())
        
        
        
        
        let subscription = observable.subscribe { (event) in
            print(event)
        }
        
        subscription.dispose()
        
        observable.subscribe { (event) in
            print(event)
        }

    }

}
