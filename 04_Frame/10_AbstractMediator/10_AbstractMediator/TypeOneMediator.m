//
//  TypeOneMediator.m
//  10_AbstractMediator
//
//  Created by Daiyi on 2021/2/26.
//

#import "TypeOneMediator.h"

@implementation TypeOneMediator

- (NSDictionary *)values {
    return @{
        @"A": @(self.colleagueA.value),
        @"B": @(self.colleagueB.value),
        @"C": @(self.colleagueC.value)
    };
}

- (void)colleagueEvent:(AbstractColleague *)colleague {
    if ([colleague isEqual:self.colleagueA]) {
        self.colleagueB.value = self.colleagueA.value * 2;
        self.colleagueC.value = self.colleagueA.value * 4;
    } else if ([colleague isEqual:self.colleagueB]) {
        self.colleagueA.value = self.colleagueB.value / 2;
        self.colleagueC.value = self.colleagueB.value * 2;
    } else {
        self.colleagueA.value = self.colleagueB.value / 4;
        self.colleagueB.value = self.colleagueB.value / 2;
    }
}

@end
