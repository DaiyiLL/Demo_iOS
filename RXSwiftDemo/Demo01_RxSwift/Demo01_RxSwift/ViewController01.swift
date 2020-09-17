//
//  ViewController01.swift
//  Demo01_RxSwift
//
//  Created by yidai on 2019/8/7.
//  Copyright © 2019 daishuyi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController01: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        let observable = Observable<Int>.timer(4, period: 5, scheduler: MainScheduler.instance)
        
        observable.subscribe { (event) in
            print(event.element)
        }
    }
    
    
    private func test01() {
        var isOdd = false
        let factory: Observable<Int> = Observable.deferred {
            
            isOdd = !isOdd
            
            if isOdd {
                return Observable.of(1, 3, 5, 7, 9)
            } else {
                return Observable.of(2, 4, 6, 8, 10)
            }
        }
        factory.subscribe { event in
            print("\(isOdd)", event)
        }
        
        factory.subscribe { event in
            print("\(isOdd)", event)
        }
    }

}
