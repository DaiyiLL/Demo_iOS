//
//  Kuijia.m
//  13_GameDemo
//
//  Created by Daiyi on 2021/3/3.
//

#import "Kuijia.h"
#import "Wuqi.h"

@implementation Kuijia

- (void)handlerRequest:(Gongji *)request {
    if ([request isKindOfClass:[Wuqi class]]) {
        NSLog(@"1, 攻击没有通过这个盔甲");
    } else {
        NSLog(@"1, 不是武器攻击，防不住，其他的去处理- %@", [Wuqi class]);
        [self.nextHandler handlerRequest:request];
    }
}

@end
