//
//  ViewController03.swift
//  Demo01_RxSwift
//
//  Created by yidai on 2019/8/8.
//  Copyright © 2019 daishuyi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController03: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.textColor = UIColor.green
        self.label.backgroundColor = UIColor.blue
        self.label.textAlignment = .center
        self.label.text = "Binder Test"
        self.view.addSubview(self.label)
        // Do any additional setup after loading the view.
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
//        observable
//            .map{"当前索引数: \($0)"}
//            .bind{ [weak self] (text) in
//                self?.label.text = text
//            }
//            .disposed(by: disposeBag)
        
//        observable
//            .map { CGFloat($0) }
//            .bind(to: label.fontSize)
//            .disposed(by: disposeBag)
        
//        observable
//            .map { CGFloat($0) }
//            .bind(to: label.rx.fontSize)
//            .disposed(by: disposeBag)
        
//        observable
//            .map { "当前索引数: \($0)" }
//            .bind(to: label.rx.text)
//            .disposed(by: disposeBag)
        
    }
    
    private(set) lazy var label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    
}

extension UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
