//
//  Director.h
//  09_BuilderView
//
//  Created by Daiyi on 2021/2/25.
//

#import <Foundation/Foundation.h>
#import "DrawView.h"
#import "DrawBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface Director : NSObject

+ (DrawView *)createView: (DrawBuilder *)builder;

@end

NS_ASSUME_NONNULL_END
