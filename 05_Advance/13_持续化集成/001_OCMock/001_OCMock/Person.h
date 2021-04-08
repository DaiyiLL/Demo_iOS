//
//  Person.h
//  001_OCMock
//
//  Created by Daiyi on 2021/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;

- (NSString *)getPersonName;

@end

NS_ASSUME_NONNULL_END
