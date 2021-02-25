//
//  Creater.m
//  07_BuildOne
//
//  Created by Daiyi on 2021/2/24.
//

#import "Director.h"

@interface Director()

@property (nonatomic, copy) id<Builder> builder;

@end

@implementation Director

- (instancetype)initWithBuilder:(id<Builder>)builder {
    self = [super init];
    if (self) {
        _builder = builder;
    }
    return self;
}

// 建造
- (NSString *)construct {
    // 创建部件
    return [self.builder builderPart];
}


@end
