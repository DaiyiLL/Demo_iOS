//
//  FootBall.m
//  14_GameDemo
//
//  Created by Daiyi on 2021/3/3.
//

#import "FootBall.h"

@implementation FootBall

- (instancetype)initGame {
    self = [super init];
    if (self) {
        NSLog(@"init football");
    }
    return self;
}

// 暂停
- (void)pauseGame {
    NSLog(@"pause football");
}

// 游戏存储
- (void)saveGame {
    NSLog(@"save football");
}

// 退出游戏
- (void)exitGame {
    NSLog(@"exit football");
}

// 开始游戏
- (void)startPlay {
    NSLog(@"start play football");
}

@end
