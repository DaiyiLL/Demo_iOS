//
//  DYPerson.h
//  02_KVC00
//
//  Created by Daiyi on 2021/3/28.
//

#import <Foundation/Foundation.h>
#import "DYDog.h"
NS_ASSUME_NONNULL_BEGIN

@interface DYPerson : NSObject {
    @public
    NSString* _name;
}

@property (nonatomic,   copy) NSString *name;

@property (nonatomic, strong) DYDog *dog;

@end

NS_ASSUME_NONNULL_END
