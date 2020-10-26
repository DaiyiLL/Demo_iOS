//
//  UIView+Shadow.m
//  DYFactory_Example
//
//  Created by yidai on 2020/8/14.
//  Copyright © 2020 870929851. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)

- (UIView *)makeShadowWithColor: (UIColor *)shadowColor
                         radius: (CGFloat)shadowRadius
                        opacity: (CGFloat)shadowOpacity
                         offset: (CGSize)shadowOffset  {
    UIView *shadowView = [self createShadowViewWithColor:shadowColor radius:shadowRadius opacity:shadowOpacity offset:shadowOffset];
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    shadowView.layer.shadowPath = shadowPath.CGPath;
    
    [self addShadowView:shadowView];
    return shadowView;
}

- (void)makeOrigalShadowColor: (UIColor *)shadowColor
                       radius: (CGFloat)shadowRadius
                      opacity: (CGFloat)shadowOpacity
                       offset: (CGSize)shadowOffset {
    self.layer.shadowColor   = shadowColor.CGColor;
    self.layer.shadowOffset  = shadowOffset;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius  = shadowRadius;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowPath = shadowPath.CGPath;
}


- (UIView *)makeShadowWithColor: (UIColor *)shadowColor
                         radius: (CGFloat)shadowRadius
                        opacity: (CGFloat)shadowOpacity
                         offset: (CGSize)shadowOffset
                   cornerRadius: (CGFloat)cornerRadius
                         corner: (UIRectCorner)corner  {
    
    UIView *shadowView = [self createShadowViewWithColor:shadowColor radius:shadowRadius opacity:shadowOpacity offset:shadowOffset];

    UIBezierPath *shadowPath = [self makePathWithRadius:cornerRadius corner:corner];
    shadowView.layer.shadowPath = shadowPath.CGPath;
    
    // 制作圆角
    [self makeRadius:cornerRadius corner:corner path:shadowPath];
    
    [self addShadowView:shadowView];
    return shadowView;
}

- (CAShapeLayer *)addMaskLayerWithLineWidth: (CGFloat)lineWidth
                      borderColor: (UIColor *)borderColor {
    if ([self.layer.mask isKindOfClass:[CAShapeLayer class]]) {
        CAShapeLayer *maskLayer = (CAShapeLayer *)self.layer.mask;
        // 添加边框
        CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
        borderLayer.path = maskLayer.path;
        borderLayer.fillColor = UIColor.clearColor.CGColor;
        borderLayer.strokeColor = borderColor.CGColor;
        borderLayer.lineWidth = lineWidth;
        [self.layer addSublayer:borderLayer];
        return borderLayer;
    }
    return nil;
}

- (CAShapeLayer *)makeRadius: (CGFloat)radius corner: (UIRectCorner)corner {
    UIBezierPath *maskPath = [self makePathWithRadius:radius corner:corner];
    return [self makeRadius:radius corner:corner path:maskPath];
}


- (CAShapeLayer *)makeRadius: (CGFloat)radius corner: (UIRectCorner)corner path:(UIBezierPath *)maskPath {
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    return maskLayer;
}


- (UIView *)makeSquartShadowWithColor: (UIColor *)shadowColor radius: (CGFloat)shadowRadius opacity: (CGFloat)shadowOpacity {
    return [self makeShadowWithColor:shadowColor
                              radius:shadowRadius
                             opacity:shadowOpacity
                              offset:CGSizeZero];
}


- (UIView *)makeShadowWithAttribute: (DYShadowAttribute *)attribute {
    return [self makeShadowWithColor:attribute.shadowColor
                              radius:attribute.shadowRadius
                             opacity:attribute.shadowOpacity
                              offset:attribute.shadowOffset
                        cornerRadius:attribute.cornerRadius
                              corner:attribute.corner];
}


- (void)addShadowView: (UIView *)shadowView {
    if (self.superview) {
        // 将当前的shadowView放在当前视图的下面
        [self.superview insertSubview:shadowView belowSubview:self];
    }
}

#pragma mark - 私有方法------------------------------------

- (UIView *)createShadowViewWithColor: (UIColor *)shadowColor radius: (CGFloat)shadowRadius opacity: (CGFloat)shadowOpacity offset: (CGSize)shadowOffset {
    [self layoutIfNeeded];
    [self.superview layoutIfNeeded];
    UIView *shadowView = [[UIView alloc] initWithFrame:self.frame];
    
    shadowView.layer.shadowColor   = shadowColor.CGColor;
    shadowView.layer.shadowOffset  = shadowOffset;
    shadowView.layer.shadowOpacity = shadowOpacity;
    shadowView.layer.shadowRadius  = shadowRadius;
    
    return shadowView;
}

- (UIBezierPath *)makePathWithRadius: (CGFloat)radius corner: (UIRectCorner)corner {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat half = MIN(self.bounds.size.width, self.bounds.size.height) * 0.5;
    CGFloat cornerdius = radius > half ? half : radius;
    CGFloat pWidth = self.bounds.size.width;
    CGFloat pHeight = self.bounds.size.height;
    
    CGPoint startPoint;
    if ((corner & UIRectCornerTopLeft) == UIRectCornerTopLeft) {
        startPoint = CGPointMake(0, cornerdius);
        [path moveToPoint:startPoint];
        [path addArcWithCenter: CGPointMake(cornerdius, cornerdius) radius:cornerdius startAngle:-M_PI endAngle:-M_PI_2 clockwise:true];
    } else {
        [path moveToPoint:CGPointMake(0, 0)];
        startPoint = CGPointMake(0, 0);
    }
    if ((corner & UIRectCornerTopRight) == UIRectCornerTopRight) {
        [path addLineToPoint:CGPointMake(pWidth - cornerdius, 0)];
        [path addArcWithCenter:CGPointMake(pWidth - cornerdius, cornerdius) radius:cornerdius startAngle:-M_PI_2 endAngle:0 clockwise:true];
    } else {
        [path addLineToPoint:CGPointMake(pWidth, 0)];
    }
    if ((corner & UIRectCornerBottomRight) == UIRectCornerBottomRight) {
        [path addLineToPoint:CGPointMake(pWidth, pHeight - cornerdius)];

        [path addArcWithCenter:CGPointMake(pWidth - cornerdius, pHeight - cornerdius) radius:cornerdius startAngle:0 endAngle:M_PI_2 clockwise:true];
    } else {
        [path addLineToPoint:CGPointMake(pWidth, pHeight)];
    }
    //
    if ((corner & UIRectCornerBottomLeft) == UIRectCornerBottomLeft) {
        [path addLineToPoint:CGPointMake(cornerdius, pHeight)];
        [path addArcWithCenter:CGPointMake(cornerdius, pHeight - cornerdius) radius:cornerdius startAngle:M_PI_2 endAngle:M_PI clockwise:true];
    } else {
        [path addLineToPoint:CGPointMake(0, pHeight)];
    }
    [path addLineToPoint:startPoint];
    
    
    return path;
}

@end


@implementation DYShadowAttribute

- (instancetype)init
{
    self = [super init];
    if (self) {
        _corner = UIRectCornerAllCorners;
        _shadowColor = UIColor.clearColor;
        _shadowOffset = CGSizeZero;
    }
    return self;
}


@end
