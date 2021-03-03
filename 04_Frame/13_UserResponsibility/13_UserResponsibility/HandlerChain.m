//
//  HandlerChain.m
//  13_UserResponsibility
//
//  Created by Daiyi on 2021/3/3.
//

#import "HandlerChain.h"

@interface HandlerChain()

@property (nonatomic, strong) id<UserProtocol> nextSuccessor;

@end

@implementation HandlerChain

- (void)setSuccessor:(id<UserProtocol>)successor {
    _nextSuccessor = successor;
}

- (id<UserProtocol>)successor {
    return _nextSuccessor;
}

- (void)handlerRequest:(id)request {
    [_nextSuccessor handlerRequest:request];
}

@end
