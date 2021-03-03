//
//  Mokang.m
//  13_GameDemo
//
//  Created by Daiyi on 2021/3/3.
//

#import "Mokang.h"
#import "Mofa.h"

@implementation Mokang

- (void)handlerRequest:(Gongji *)request {
    if ([request isKindOfClass:[Mofa class]]) {
        NSLog(@"1, 攻击没有通过这个魔抗盔甲");
    } else {
        NSLog(@"1, 不是魔法攻击，防不住，其他的去处理- %@", [Mofa class]);
        [self.nextHandler handlerRequest:request];
    }
}

@end
