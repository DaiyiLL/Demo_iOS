//
//  Director.m
//  08_Builder_Mac
//
//  Created by Daiyi on 2021/2/25.
//

#import "Director.h"

@interface Director()

@property (nonatomic, strong) id<MacBuilder> builder;

@end

@implementation Director

- (instancetype)initWithBuilder:(id<MacBuilder>)builder {
    self = [super init];
    if (self) {
        _builder = builder;
    }
    return self;
}

- (void)constructCPU:(NSString *)cpu display:(NSString *)display mainboard:(NSString *)mainboard os:(NSString *)os {
//    [_builder buildCPU:cpu];
//    [_builder buildDisplay:display];
//    [_builder buildMainboard:mainboard];
//    [_builder buildSystemOS:os];
    [[[[_builder buildCPU:cpu] buildDisplay:display] buildMainboard:mainboard] buildSystemOS:os];
    
}

@end
