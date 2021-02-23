//
//  Person.h
//  05_MsgSend、
//
//  Created by Daiyi on 2021/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *age;

//- (void)run: (Person *)str;
- (void)run;

@end

NS_ASSUME_NONNULL_END
