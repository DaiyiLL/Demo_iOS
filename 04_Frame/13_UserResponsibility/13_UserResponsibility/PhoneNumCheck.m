//
//  PhoneNumCheck.m
//  13_UserResponsibility
//
//  Created by Daiyi on 2021/3/3.
//

#import "PhoneNumCheck.h"
#import <RegExCategories/RegExCategories.h>

@interface PhoneNumCheck()

@property (nonatomic, strong) id<UserProtocol> nextSuccessor;

@end

@implementation PhoneNumCheck

- (void)setSuccessor:(id<UserProtocol>)successor {
    _nextSuccessor = successor;
}

- (id<UserProtocol>)successor {
    return _nextSuccessor;
}

- (void)handlerRequest:(id)request {
    NSString *string = request;
    BOOL isMatch = [string isMatch:RX(@"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$")];
    if (isMatch) {
        NSLog(@"%@ 是电话号码", string);
    } else {
        [_nextSuccessor handlerRequest:request];
    }
}

@end
