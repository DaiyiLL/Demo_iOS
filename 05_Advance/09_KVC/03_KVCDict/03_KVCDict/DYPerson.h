//
//  DYPerson.h
//  03_KVCDict
//
//  Created by Daiyi on 2021/3/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYPerson : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) float     height;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableArray *penArr;

@end

NS_ASSUME_NONNULL_END
