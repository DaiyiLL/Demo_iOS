//
//  StudentModel.h
//  18_PrototypeDemo
//
//  Created by Daiyi on 2021/3/8.
//

#import <Foundation/Foundation.h>
#import "PrototypeCopyProtocol.h"
#import "BaseCopyObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface StudentModel : BaseCopyObject <PrototypeCopyProtocol>

@property (nonatomic,   copy) NSString *name;
@property (nonatomic,   copy) NSString *address;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSNumber *totalScore;

@end

NS_ASSUME_NONNULL_END
