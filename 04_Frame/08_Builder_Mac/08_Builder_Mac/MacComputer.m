//
//  MacComputer.m
//  08_Builder_Mac
//
//  Created by Daiyi on 2021/2/24.
//

#import "MacComputer.h"

@implementation MacComputer

- (void)CPU:(nonnull NSString *)cpu {
    NSLog(@"Mac 电脑处理器: %@", cpu);
}

- (void)Display:(nonnull NSString *)display {
    NSLog(@"Mac 电脑显卡: %@", display);
}

- (void)Mainboard:(nonnull NSString *)mainboard {
    NSLog(@"Mac 电脑主板: %@", mainboard);
}

- (void)SystemOS:(nonnull NSString *)os {
    NSLog(@"Mac 电脑系统: %@", os);
}

@end
