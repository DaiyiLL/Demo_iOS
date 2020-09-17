//
//  MustListViewModel.swift
//  Demo01_RxSwift
//
//  Created by yidai on 2019/8/7.
//  Copyright © 2019 daishuyi. All rights reserved.
//

import Foundation
import RxSwift

struct MusicListViewModel {
//    let data = [
//        Music(name: "无条件", singer: "陈奕迅"),
//        Music(name: "你曾是少年", singer: "S.H.E"),
//        Music(name: "从前的我", singer: "陈洁仪"),
//        Music(name: "在木星", singer: "朴树"),
//    ]
    let data = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
        ])
}
