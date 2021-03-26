//
//  DYPerson.h
//  01_Runtime_02
//
//  Created by Daiyi on 2021/3/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYPerson : NSObject <NSCoding>

@property (nonatomic,   copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic,   copy) NSString *address;

- (instancetype)initWithCoder:(NSCoder *)coder;

@end

NS_ASSUME_NONNULL_END
