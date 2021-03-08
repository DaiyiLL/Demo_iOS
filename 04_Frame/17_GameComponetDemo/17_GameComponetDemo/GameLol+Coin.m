//
//  GameLol+Coin.m
//  17_GameComponetDemo
//
//  Created by Daiyi on 2021/3/8.
//

#import "GameLol+Coin.h"
#import <objc/runtime.h>

static const NSString *_coinStr = @"_coinStr";
@implementation GameLol (Coin)

- (void)setCoin:(NSInteger)coin {
    objc_setAssociatedObject(self, (__bridge const void *)_coinStr, @(coin), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)coin {
    id value = objc_getAssociatedObject(self, (__bridge const void *)_coinStr);
    if (value && [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

@end
