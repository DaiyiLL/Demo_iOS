//
//  SecondViewController.swift
//  RAC102_RxSwiftDemo
//
//  Created by Daiyi on 2021/3/12.
//

import UIKit
import RxSwift

class SecondViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Second"

        // Do any additional setup after loading the view.
        
//        let observalbe = Observable.of(1, 2, 3)
        
        
        
        
    }
    
    private func demo03() {
        let subscribption = Observable.from([1, 2, 3])
            .subscribe(onNext: {
                print("\($0)")
            }).disposed(by: self.disposeBag)
    }
    
    private func demo02() {
        let observalbe = Observable.of(1, 2, 3)
        observalbe.subscribe { (element) in
            print("onNext: \(element)")
        } onError: { (error) in
            print("onError: \(error)")
        } onCompleted: {
            print("onCompleted")
        } onDisposed: {
            print("onDisposed")
        }.disposed(by: DisposeBag())
    }
    
    private func  demo01() {
        let emptySuquence = Observable<Int>.empty()
        emptySuquence.subscribe { (_) in
            print("empty 已经来到")
        }.disposed(by: self.disposeBag)
    }

    private func demo00() {
        let nevelSequence = Observable<String>.never()
//        let nevelSequence = Observable<String>.just("1")
        nevelSequence.subscribe { (_)in
            print("永远不会发生")
        }.disposed(by: self.disposeBag)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
