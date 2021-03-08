//
//  GameDecortor.h
//  17_GameComponetDemo
//
//  Created by Daiyi on 2021/3/8.
//

#import <Foundation/Foundation.h>
#import "GameLol.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameDecortor : NSObject

- (instancetype)initWithGame: (GameLol *)game;

// 上下左右
- (void)up;
- (void)down;
- (void)left;
- (void)right;

// 选择与开始的操作
- (void)select;
- (void)start;

// 按钮
- (void)commandA;
- (void)commandB;
- (void)commandC;
- (void)commandD;

@end

NS_ASSUME_NONNULL_END
