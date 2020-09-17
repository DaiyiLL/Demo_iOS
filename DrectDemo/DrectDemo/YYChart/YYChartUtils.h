//
//  YYChartUtils.h
//  DrectDemo
//
//  Created by yidai on 2020/5/4.
//  Copyright © 2020 yidai. All rights reserved.
//

#ifndef YYChartUtils_h
#define YYChartUtils_h

#import "YYChartModel.h"

#define YY_CHART_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define YY_CHART_RGB(r,g,b)    YY_CHART_RGBA(r,g,b,1.0f)
#define YY_CHART_RGBAS(s)      YY_CHART_RGBA(s,s,s,1.0f)

static NSInteger const YY_DOT_START_TAG = 1000;

#endif /* YYChartUtils_h */
