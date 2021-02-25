//
//  Director.m
//  09_BuilderView
//
//  Created by Daiyi on 2021/2/25.
//

#import "Director.h"
#import "DrawBuilder.h"

@interface Director()



@end

@implementation Director

+ (DrawView *)createView: (DrawBuilder *)builder {
    DrawView *drawView = [builder loadView];
    return drawView;
}

@end
