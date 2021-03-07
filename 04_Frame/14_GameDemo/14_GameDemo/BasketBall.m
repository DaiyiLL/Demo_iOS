//
//  BasketBall.m
//  14_GameDemo
//
//  Created by Daiyi on 2021/3/3.
//

#import "BasketBall.h"

@implementation BasketBall

- (instancetype)initGame {
    self = [super init];
    if (self) {
        NSLog(@"init BasketBall");
    }
    return self;
}

// 暂停
- (void)pauseGame {
    NSLog(@"pause BasketBall");
}

// 游戏存储
- (void)saveGame {
    NSLog(@"save BasketBall");
}

// 退出游戏
- (void)exitGame {
    NSLog(@"exit BasketBall");
}

// 开始游戏
- (void)startPlay {
    NSLog(@"start play BasketBall");
}


@end
