//
//  Music.swift
//  Demo01_RxSwift
//
//  Created by yidai on 2019/8/7.
//  Copyright © 2019 daishuyi. All rights reserved.
//

import Foundation

struct Music {
    let name: String
    let singer: String
    
    init(name: String, singer: String) {
        self.name = name;
        self.singer = singer;
    }
}

extension Music: CustomStringConvertible {
    var description: String {
        return "name: \(self.name), singer: \(singer)"
    }
}
