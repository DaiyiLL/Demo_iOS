//
//  Handler.h
//  13_ResponsibilityDemo
//
//  Created by Daiyi on 2021/3/2.
//

#import <Foundation/Foundation.h>
#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Handler : NSObject

@property (nonatomic, strong) Handler *successor;

- (void)handlerRequest:(Person *)request;

@end

NS_ASSUME_NONNULL_END
