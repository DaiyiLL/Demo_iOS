//
//  LinghterCommand.h
//  16_CommandDemo
//
//  Created by Daiyi on 2021/3/7.
//

#import <Foundation/Foundation.h>
#import "CommandProtocol.h"
#import "Receiver.h"

NS_ASSUME_NONNULL_BEGIN

@interface LinghterCommand : NSObject <CommandProtocol>

- (instancetype)initWithReceiver: (Receiver *)receiver param: (CGFloat)parameter;

@end

NS_ASSUME_NONNULL_END
