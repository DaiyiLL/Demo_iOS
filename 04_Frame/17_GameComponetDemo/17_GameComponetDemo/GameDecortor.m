//
//  GameDecortor.m
//  17_GameComponetDemo
//
//  Created by Daiyi on 2021/3/8.
//

#import "GameDecortor.h"

@interface GameDecortor()

@property (nonatomic, strong) GameLol *gamelol;

@end

@implementation GameDecortor

- (instancetype)initWithGame:(GameLol *)game {
    self = [super init];
    if (self) {
        _gamelol = game;
    }
    return self;
}

// 上下左右
- (void)up {
    [self.gamelol up];
}
- (void)down {
    [self.gamelol down];
}
- (void)left {
    [self.gamelol left];
}
- (void)right {
    [self.gamelol right];
}

// 选择与开始的操作
- (void)select {
    [self.gamelol select];
}
- (void)start {
    [self.gamelol start];
}

// 按钮
- (void)commandA {
    [self.gamelol commandA];
}
- (void)commandB {
    [self.gamelol commandB];
}
- (void)commandC {
    [self.gamelol commandC];;
}
- (void)commandD {
    [self.gamelol commandD];
}

@end
