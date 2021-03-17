//
//  ThirdViewController.swift
//  RAC102_RxSwiftDemo
//
//  Created by Daiyi on 2021/3/12.
//

import UIKit
import RxSwift
import RxCocoa

class ThirdViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Third"
        // Do any additional setup after loading the view.
        

    }
    
    private func demo02() {
        
    }
    
    private func demo01() {
        let disposeBag = DisposeBag()
        let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
        replaySubject.addObservariable("No1").disposed(by: disposeBag)
        replaySubject.onNext("第一个事件")
        replaySubject.onNext("第二个事件")
        replaySubject.onNext("第A个事件")
        
        
        replaySubject.addObservariable("No2").disposed(by: disposeBag)
        replaySubject.onNext("第3个事件")
        replaySubject.onNext("第4个事件")
        replaySubject.onNext("第B个事件")
    }
    
    private func demo00() {
        let disposeBag = DisposeBag()
        let publishSubject = PublishSubject<String>()
        publishSubject.addObservariable("No1").disposed(by: disposeBag)
        publishSubject.onNext("2")
        publishSubject.onNext("3")
        
        publishSubject.addObservariable("No2").disposed(by: disposeBag)
        publishSubject.onNext("A")
        publishSubject.onNext("B")
    }
    

}

extension Observable {
    func addObservariable(_ id: String) -> Disposable {
        return subscribe {
            print("Subscription", id, "Event: ", $0)
        }
    }
}

extension ObservableType {
    func addObservariable(_ id: String) -> Disposable {
        return subscribe {
            print("Subscription", id, "Event: ", $0)
        }
    }
}


