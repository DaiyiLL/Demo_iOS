//
//  ViewController08.swift
//  Demo01_RxSwift
//
//  Created by yidai on 2019/8/8.
//  Copyright © 2019 daishuyi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController08: UIViewController {

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let variable = BehaviorRelay(value: subject1)
        
//        variable.asObservable()
//            .flatMap{ $0 }
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
        
//        variable.asObservable()
//            .flatMapLatest{ $0 }
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
        
        variable.asObservable()
            .concatMap{ $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        variable.accept(subject2)
        
        subject2.onNext("2")
        subject1.onNext("C")
        subject1.onCompleted()
        
        
    }
    
    private final func test02() {
        Observable.of(1, 2, 3)
            .map {$0 * 10}
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }
    
    private final func test01() {
        let subject = PublishSubject<String>()
        
        // 没缓存三个元素则组合起来一起发出
        // 如果1秒钟内不够3个也会发出（有几个发几个，一个都没有发空数组 []）
        subject
            .buffer(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        //        subject
        //            .window(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
        //            .subscribe(onNext: { [weak self] in
        //                print("subscribe: \($0)")
        //                $0.asObservable()
        //                    .subscribe(onNext: {print($0)})
        //                    .disposed(by: self!.disposeBag)
        //            })
        //            .disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        
        subject.onNext("AAAA")
        subject.onNext("BBBB")
    }


}
