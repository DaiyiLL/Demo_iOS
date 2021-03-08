//
//  DarkerCommand.m
//  16_CommandDemo
//
//  Created by Daiyi on 2021/3/7.
//

#import "DarkerCommand.h"

@interface DarkerCommand()

@property (nonatomic, strong) Receiver *receiver;
@property (nonatomic, assign) CGFloat   parameter;

@end

@implementation DarkerCommand

- (instancetype)initWithReceiver:(Receiver *)receiver param:(CGFloat)parameter
{
    self = [super init];
    if (self) {
        _receiver = receiver;
        _parameter = parameter;
    }
    return self;
}



- (void)excuteCommand {
    [_receiver makeDart:_parameter];
}

- (void)gobackCommand {
    [_receiver makeLighter:_parameter];
}

@end
