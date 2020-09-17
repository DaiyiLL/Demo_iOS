//
//  YYChartView.m
//  DrectDemo
//
//  Created by yidai on 2020/5/4.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "YYChartView.h"
#import "YYChartUtils.h"

@interface YYChartView()

@property (nonatomic, assign) CGFloat  yyCenterX;
@property (nonatomic, assign) CGFloat  yyCenterY;

@property (nonatomic, assign) CGFloat  startX;
@property (nonatomic, assign) CGFloat  endX;

@property (nonatomic, assign) CGFloat  startY;
@property (nonatomic, assign) CGFloat  endY;

@property (nonatomic, assign) CGFloat  xRate;
@property (nonatomic, assign) CGFloat  yRate;

@property (nonatomic, strong) NSMutableArray<UILabel *> *yLabels;
@property (nonatomic, strong) NSMutableArray<UILabel *> *xLabels;

@property (nonatomic,   weak) UILabel *daLabel;
@property (nonatomic,   weak) UILabel *dbLabel;

@property (nonatomic, strong) NSMutableArray<UIButton *> *dotList;

@end

@implementation YYChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 空出一定间距来划线
        _innerPadding = UIEdgeInsetsMake(0, 24, 24, 2);
        _halfLineCount = 5;
        _verticalAbs = 50;
        _horizontalAbs = 50;
        _dataList = @[];
        
        [self commentInit];
    }
    return self;
}

- (void)commentInit {
    
    
    CGFloat maxWidth = self.bounds.size.width;
    CGFloat maxHeight = self.bounds.size.height;
    
    // 水平
    _startX = _innerPadding.left;
    _endX = maxWidth - _innerPadding.right;
    
    // 垂直
    _startY = _innerPadding.top;
    _endY = maxHeight - _innerPadding.bottom;
    
    _yyCenterX = _startX + (_endX - _startX) * 0.5;
    _yyCenterY = _startY + (_endY - _startY) * 0.5;
    
    NSInteger spaceCount = (_halfLineCount * 2);
    _xRate = (_endX - _startX) / spaceCount;
    _yRate = (_endY - _startY) / spaceCount;
    
    // 添加轴显示
    NSArray *xTitles = @[[NSString stringWithFormat:@"-%ld", _horizontalAbs], @"0", [NSString stringWithFormat:@"%ld", _horizontalAbs]];
    NSArray *yTitles = @[[NSString stringWithFormat:@"-%ld", _verticalAbs], @"0", [NSString stringWithFormat:@"%ld", _verticalAbs]];
    _xLabels = [NSMutableArray arrayWithCapacity:xTitles.count];
    _yLabels = [NSMutableArray arrayWithCapacity:yTitles.count];
    UIColor *titleColor = YY_CHART_RGBAS(153);
    UIFont  *titleFont = [UIFont systemFontOfSize:10.0];
    CGFloat  titleHeight = titleFont.lineHeight;
    CGFloat  titleWidth  = _innerPadding.left;
    [xTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth, titleWidth)];
        [self addSubview:label];
        label.text = title;
        // 因为可能出现负数，所以必须为NSInteger，否者NSUInteger - 1是一个非常大的数
        NSInteger index = idx;
        label.center = CGPointMake((NSInteger)(_yyCenterX + (index - 1) * (_yyCenterX - _startX - titleWidth * 0.5)), _endY + titleWidth * 0.5);
        label.textAlignment = NSTextAlignmentCenter + (index - 1);
        label.textColor = titleColor;
        label.font = titleFont;
        [_xLabels addObject:label];
    }];
    
    [yTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
           UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth, titleHeight)];
        [self addSubview:label];
        label.text = title;
        NSInteger index = idx;
        label.center = CGPointMake(label.center.x, (NSInteger)(_yyCenterY + (index - 1) * (_yyCenterY - _startY - titleHeight * 0.5)));
        label.textColor = titleColor;
        label.font = titleFont;
        [_yLabels addObject:label];
    }];
    
    UILabel *dbLabel = [[UILabel alloc] initWithFrame:CGRectMake(_yyCenterX, _startY, _xRate, _yRate)];
    [self addSubview:dbLabel];
    _dbLabel = dbLabel;
    dbLabel.textAlignment = NSTextAlignmentCenter;
    dbLabel.font = titleFont;
    dbLabel.textColor = titleColor;
    dbLabel.text = @"db";
    
    UILabel *daLabel = [[UILabel alloc] initWithFrame:CGRectMake(_endX - _xRate, _yyCenterY, _xRate, _yRate)];
    [self addSubview:daLabel];
    _daLabel = daLabel;
    daLabel.textAlignment = NSTextAlignmentCenter;
    daLabel.font = titleFont;
    daLabel.textColor = titleColor;
    daLabel.text = @"da";
    
}

- (NSMutableArray<UIButton *> *)dotList {
    if (!_dotList) {
        _dotList = [NSMutableArray arrayWithCapacity:0];
    }
    return _dotList;
}

- (void)reloadAllViews {
    // 坐标轴的显示
    NSArray *xTitles = @[[NSString stringWithFormat:@"-%ld", _horizontalAbs], @"0", [NSString stringWithFormat:@"%ld", _horizontalAbs]];
    NSArray *yTitles = @[[NSString stringWithFormat:@"-%ld", _verticalAbs], @"0", [NSString stringWithFormat:@"%ld", _verticalAbs]];
    int i = 0;
    for (UILabel *label in _xLabels) {
        label.text = xTitles[i];
        i++;
    }
    i = 0;
    for (UILabel *label in _yLabels) {
        label.text = yTitles[i];
        i++;
    }
    
    YYChartModel *model1 = [[YYChartModel alloc] init];
    model1.da = -20;
    model1.db = 30;
    
    YYChartModel *model2 = [[YYChartModel alloc] init];
    model2.da = -30;
    model2.db = -30;
    
    YYChartModel *model3 = [[YYChartModel alloc] init];
    model3.da = 10;
    model3.db = -20;
    
    _dataList = @[model1, model2, model3];
    CGFloat vRate = (_endY - _startY) * 0.5 / _verticalAbs;
    CGFloat hRate = (_endX - _startX) * 0.5 / _horizontalAbs;
    for (YYChartModel *model in _dataList) {
        model.center = CGPointMake((NSInteger)(_yyCenterX + hRate * model.da), (NSInteger)(_yyCenterY + vRate * model.db));
    }
    
    // 触发Drect
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetStrokeColorWithColor(context, YY_CHART_RGBAS(153).CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    //drawing x vector
    CGContextMoveToPoint(context, _startX, _yyCenterY);
    CGContextAddLineToPoint(context, _endX, _yyCenterY);
    //drawing y vector
    CGContextMoveToPoint(context, _yyCenterX, _startY);
    CGContextAddLineToPoint(context, _yyCenterX, _endY);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    
    CGContextSetStrokeColorWithColor(context, YY_CHART_RGBAS(189).CGColor);
    CGContextSetLineWidth(context, 1.0 / UIScreen.mainScreen.scale);
    
    
    for (int i = 1; i <= _halfLineCount; i++) {
        // 上
        CGFloat upY = _yyCenterY - i * _yRate;
        CGContextMoveToPoint(context, _startX, upY);
        CGContextAddLineToPoint(context, _endX, upY);
        // 下
        CGFloat downY = _yyCenterY + i * _yRate;
        CGContextMoveToPoint(context, _startX, downY);
        CGContextAddLineToPoint(context, _endX, downY);
    }
    
    for (int i = 1; i <= _halfLineCount; i++) {
        // 左
        CGFloat leftX = _yyCenterX - i * _xRate;
        CGContextMoveToPoint(context, leftX, _startY);
        CGContextAddLineToPoint(context, leftX, _endY);
        // 下
        CGFloat rightX = _yyCenterX + i * _xRate;
        CGContextMoveToPoint(context, rightX, _startY);
        CGContextAddLineToPoint(context, rightX, _endY);
    }
    CGContextDrawPath(context, kCGPathStroke);
    
    // 划线
    CGContextSetStrokeColorWithColor(context, YY_CHART_RGBAS(153).CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    for (YYChartModel *model in _dataList) {
        CGContextMoveToPoint(context, _yyCenterX, _yyCenterY);
        CGContextAddLineToPoint(context, model.center.x, model.center.y);
    }
    
    CGContextDrawPath(context, kCGPathStroke);
    
    // 添加view
    [self showDotViews];
}

- (void)showDotViews {
    for (UIButton *dotView in self.dotList) {
        [dotView removeFromSuperview];
    }
    [_dotList removeAllObjects];
    
    [_dataList enumerateObjectsUsingBlock:^(YYChartModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:btn];
        btn.tag = YY_DOT_START_TAG + idx;
        btn.frame = CGRectMake(0, 0, 10, 10);
        btn.center = model.center;
        btn.backgroundColor = UIColor.blueColor;
        [btn addTarget:self action:@selector(dotClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }];
    
    
}

- (void)dotClicked: (UIButton *)sender {
    
}


@end
