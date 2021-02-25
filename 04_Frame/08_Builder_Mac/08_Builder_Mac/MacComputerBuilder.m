//
//  MacComputerBuilder.m
//  08_Builder_Mac
//
//  Created by Daiyi on 2021/2/24.
//

#import "MacComputerBuilder.h"
#import "MacComputer.h"

@interface MacComputerBuilder()

@property (nonatomic, strong) id<MacComputerProtocol> computer;

@end

// 雷士的调用方式，就是典型的构建者调用模式
@implementation MacComputerBuilder

- (instancetype)init
{
    self = [super init];
    if (self) {
        _computer = [[MacComputer alloc] init];
    }
    return self;
}


- (id<MacComputerProtocol>)build {
    // 此处省略500行代码
    
    return _computer;
}

- (nonnull id<MacBuilder>)buildCPU:(nonnull NSString *)cpu {
    [_computer CPU:cpu];
    return self;
}

- (nonnull id<MacBuilder>)buildDisplay:(nonnull NSString *)display {
    [_computer Display:display];
    return self;
}

- (nonnull id<MacBuilder>)buildMainboard:(nonnull NSString *)mainboard {
    [_computer Mainboard:mainboard];
    return self;
}

- (nonnull id<MacBuilder>)buildSystemOS:(nonnull NSString *)os {
    [_computer SystemOS:os];
    return self;
}

@end
