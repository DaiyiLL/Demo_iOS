//
//  ViewController07.swift
//  Demo01_RxSwift
//
//  Created by yidai on 2019/8/8.
//  Copyright © 2019 daishuyi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController07: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let disposeBag = DisposeBag()
        
        // 创建一个初始值为111的Variable
        let variable = BehaviorRelay(value: "111");
        
        // 修改value值
        variable.accept("222")
        
        // 第1次订阅
        variable.asObservable().subscribe {
            print("第1次订阅: ", $0)
        }.disposed(by: disposeBag)
        
        // 再次修改value值
        variable.accept("333")
        
        // 第2次订阅
        variable.asObservable().subscribe {
            print("第2次订阅: ", $0)
        }.disposed(by: disposeBag)
        
        // 修改value的值
        variable.accept("444")
    }
    
    private func test03() {
        let disposeBag = DisposeBag()
        
        //创建一个bufferSize为2的ReplaySubject
        let subject = ReplaySubject<String>.create(bufferSize: 10)
        
        //连续发送3个next事件
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")
        
        //第1次订阅subject
        subject.subscribe { event in
            print("第1次订阅：", event)
            }.disposed(by: disposeBag)
        
        //再发送1个next事件
        subject.onNext("444")
        
        //第2次订阅subject
        subject.subscribe { event in
            print("第2次订阅：", event)
            }.disposed(by: disposeBag)
        
        //让subject结束
        subject.onCompleted()
        
        //第3次订阅subject
        subject.subscribe { event in
            print("第3次订阅：", event)
            }.disposed(by: disposeBag)
    }
    
    private func test02() {
        let disposeBag = DisposeBag()
        
        let subject = BehaviorSubject(value: "111")
        
        // 第一次订阅subject
        subject.subscribe { (event) in
            print("第一次订阅: ", event)
            }.disposed(by: disposeBag)
        
        // 发送next时间
        subject.onNext("222")
        
        //        subject.onNext("333")
        // 发送error事件
        subject.onError(NSError(domain: "local", code: 0, userInfo: nil))
        
        
        // 第二次订阅subject
        subject.subscribe { (event) in
            print("第二次订阅: ", event)
            }.disposed(by: disposeBag)
        
        subject.onNext("333")
    }
    
    private func test01() {
        let disposeBag = DisposeBag()
        
        let subject = PublishSubject<String>()
        // 由于当前没有任何订阅者，所以这条信息不回输出到控制台
        subject.onNext("111")
        
        // 第一次订阅subject
        subject.subscribe(onNext: { string in
            print("第一次订阅: ", string)
        }, onCompleted: {
            print("第一次订阅: onCompleted")
        }).disposed(by: disposeBag)
        
        // 当前有一个订阅，则该信息会输出到控制台
        subject.onNext("222")
        
        // 第二次订阅subject
        subject.subscribe(onNext: { (string) in
            print("第二次订阅: ", string)
        }, onCompleted: {
            print("第二次订阅: onCompleted")
        }).disposed(by: disposeBag)
        
        // 当前有2个订阅，则该信息会输出到控制台
        subject.onNext("333")
        
        // 让subject结束
        subject.onCompleted()
        
        // subject完成后会发出.next时间了
        subject.onNext("444")
        
        subject.subscribe(onNext: { (string) in
            print("第三次订阅: ", string)
        }, onCompleted: {
            print("第三次订阅: onCompleted")
        }).disposed(by: disposeBag)
    }

}
