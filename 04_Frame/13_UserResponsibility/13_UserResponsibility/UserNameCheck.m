//
//  UserNameCheck.m
//  13_UserResponsibility
//
//  Created by Daiyi on 2021/3/3.
//

#import "UserNameCheck.h"

#import <RegExCategories/RegExCategories.h>

@interface UserNameCheck()

@property (nonatomic, strong) id<UserProtocol> nextSuccessor;

@end

@implementation UserNameCheck

- (void)setSuccessor:(id<UserProtocol>)successor {
    _nextSuccessor = successor;
}

- (id<UserProtocol>)successor {
    return _nextSuccessor;
}

- (void)handlerRequest:(id)request {
    NSString *string = request;
    BOOL isMatch = [string isMatch:RX(@"^[A-Za-z0-9]{6,20}+$")];
    if (isMatch) {
        NSLog(@"%@ 是用户名称", string);
    } else {
        NSLog(@"校验不通过");
    }
}

@end

