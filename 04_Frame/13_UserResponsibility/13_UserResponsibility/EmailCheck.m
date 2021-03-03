//
//  EmailCheck.m
//  13_UserResponsibility
//
//  Created by Daiyi on 2021/3/3.
//

#import "EmailCheck.h"
#import <RegExCategories/RegExCategories.h>

@interface EmailCheck()

@property (nonatomic, strong) id<UserProtocol> nextSuccessor;

@end

@implementation EmailCheck

- (void)setSuccessor:(id<UserProtocol>)successor {
    _nextSuccessor = successor;
}

- (id<UserProtocol>)successor {
    return _nextSuccessor;
}

- (void)handlerRequest:(id)request {
    NSString *string = request;
    BOOL isMatch = [string isMatch:RX(@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")];
    if (isMatch) {
        NSLog(@"%@ 是邮箱", string);
    } else {
        [_nextSuccessor handlerRequest:request];
    }
}

@end
