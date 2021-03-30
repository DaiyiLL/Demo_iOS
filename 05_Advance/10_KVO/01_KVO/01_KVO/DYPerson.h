//
//  DYPerson.h
//  01_KVO
//
//  Created by Daiyi on 2021/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYPerson : NSObject

@property (nonatomic, assign) int steps;

// 依赖关系
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@end

NS_ASSUME_NONNULL_END
