//
//  Game.h
//  14_GameDemo
//
//  Created by Daiyi on 2021/3/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Game : NSObject

- (instancetype)initGame;

// 暂停
- (void)pauseGame;

// 游戏存储
- (void)saveGame;

// 退出游戏
- (void)exitGame;

// 开始游戏
- (void)startPlay;

@end

NS_ASSUME_NONNULL_END
