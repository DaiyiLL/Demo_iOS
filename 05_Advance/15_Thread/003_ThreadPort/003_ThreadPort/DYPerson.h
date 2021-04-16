//
//  DYPerson.h
//  003_ThreadPort
//
//  Created by Daiyi on 2021/4/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYPerson : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (void)personLaunchThreadWithPort: (NSPort *)port;

@end

NS_ASSUME_NONNULL_END
