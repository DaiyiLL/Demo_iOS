//
//  ViewController.swift
//  RAC102_RxSwiftDemo
//
//  Created by Daiyi on 2021/3/12.
//

import UIKit
import RxSwift
import RxCocoa

class FirstViewController: UIViewController {
    
    @IBOutlet weak var helloLbl: UILabel!
    @IBOutlet weak var nameEntryTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var namesLbl: UILabel!
    @IBOutlet weak var addNameBtn: UIButton!
    
    private lazy var disposeBag = DisposeBag()
    
    var nameArray: BehaviorRelay<[String]> = BehaviorRelay(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "First"
        
//        self.bind()
//        
//        self.bindSubmitButton()
    }
    
    func bindSubmitButton() {
        self.submitBtn.rx.tap
            .subscribe(onNext: { [weak self](_)in
                guard let `self` = self else {return}
                if let text = self.nameEntryTextField.text, !text.isEmpty {
                    var values = self.nameArray.value
                    values.append(text)
                    self.nameArray.accept(values)
                    self.namesLbl.rx.text.onNext(self.nameArray.value.joined(separator: ","));
                    self.nameEntryTextField.rx.text.onNext("")
                }
            }).disposed(by: self.disposeBag)
    }
    
    func bind() {
        self.nameEntryTextField.rx.text
            .map {
                if let str = $0, !str.isEmpty {
                    return "Hello, \(str)"
                } else {
                    return "请输入你的名字"
                }
            }.debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: self.helloLbl.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    private func demo04() {
        var accountSubject = ReplaySubject<Double>.create(bufferSize: 3)
        var accountManager = accountSubject.subscribe {
            print("火车票的价格\($0)")
        }
        accountSubject.onNext(12.49)
        accountSubject.onNext(322.49)
        accountSubject.onNext(1324.49)
        accountSubject.onNext(23434.49)
        
        print("\n")
        var lastTrheeTractions = accountSubject.subscribe {
            print("第二次订阅火车票的价格: \($0)")
        }
    }
    
    private func demo03() {
        var behaviorSubject = BehaviorSubject(value: "A")
        let subscriptionOne = behaviorSubject.subscribe {
            print("订阅者1： \($0)")
        }
        behaviorSubject.onNext("B")
        behaviorSubject.onNext("C")
        behaviorSubject.onNext("D")
        
        let subscriptionTwo = behaviorSubject.subscribe {
            print("订阅者2： \($0)")
        }
        behaviorSubject.onNext("都需要订阅")
    }
    
    private func demo02() {
        var publishSubject = PublishSubject<String>()
        publishSubject.onNext("hello")
        let publishSubscription = publishSubject.subscribe {
            print($0)
        }
        publishSubject.onNext("hello1")
        publishSubject.onNext("hello2")
        
    }
    
    private func demo01() {
        let _ = Observable<String>.create({ observeOfString in
            print("观察者被创建了")
            
            observeOfString.on(.next("daishuyi"))
            observeOfString.on(.completed)
            return Disposables.create()
        }).subscribe { (event) in
            print(event)
        }
    }

    private func demo00() {
        let numberSquence = Observable.just(5)
        numberSquence.subscribe(onNext: { [weak self](value) in
            print(value)
        }).disposed(by: self.disposeBag)
        self.disposeBag = DisposeBag()
        
        let helloSequence = Observable.from(["D", "a", "i", "Y", "i"])
        let helloSubscription = helloSequence.subscribe { (event) in
            switch event {
            case .next(let value):
                print(value)
            case .error(let error):
                print(error)
            case .completed:
                print("OK!")
            }
        }
    }

}

