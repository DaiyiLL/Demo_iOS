//
//  Colleague.m
//  10_AbstractMediator
//
//  Created by Daiyi on 2021/2/26.
//

#import "Colleague.h"

@implementation Colleague

- (void)changeValue:(CGFloat)value {
    self.value = value;
    if (self.delegate && [self.delegate respondsToSelector:@selector(colleagueEvent:)]) {
        [self.delegate colleagueEvent:self];
    }
}

@end
