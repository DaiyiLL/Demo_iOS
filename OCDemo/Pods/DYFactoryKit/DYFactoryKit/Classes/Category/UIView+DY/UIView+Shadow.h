//
//  UIView+Shadow.h
//  DYFactory_Example
//
//  Created by yidai on 2020/8/14.
//  Copyright © 2020 870929851. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DYShadowAttribute;
NS_ASSUME_NONNULL_BEGIN

@interface UIView (Shadow)

/**
 添加一个shadowView，将shadowView添加到当前视图的下面

 @param shadowView shadowView
 */
- (void)addShadowView: (UIView *)shadowView;

/**
 创建不带有任何圆角阴影

 @param shadowColor  阴影的颜色
 @param shadowRadius 阴影的扩散半径
 @param shadowOpacity 阴影的透明度
 @param shadowOffset  阴影的偏移
 @return 阴影视图
 */
- (UIView *)makeShadowWithColor: (UIColor *)shadowColor
                         radius: (CGFloat)shadowRadius
                        opacity: (CGFloat)shadowOpacity
                         offset: (CGSize)shadowOffset;

/**
该方法创建阴影不会新创建一个shadowView

@param shadowColor  阴影的颜色
@param shadowRadius 阴影的扩散半径
@param shadowOpacity 阴影的透明度
@param shadowOffset  阴影的偏移
@return 阴影视图
*/
- (void)makeOrigalShadowColor: (UIColor *)shadowColor
                       radius: (CGFloat)shadowRadius
                      opacity: (CGFloat)shadowOpacity
                       offset: (CGSize)shadowOffset;

/**
 创建指定圆角的阴影，并将视图做相应的圆角处理

 @param shadowColor  阴影的颜色
 @param shadowRadius 阴影的扩散半径
 @param shadowOpacity 阴影的透明度
 @param shadowOffset  阴影的偏移
 @param cornerRadius  视图的圆角半径，包括阴影的圆角半径
 @param corner        指定的圆角
 @return 阴影视图
 */
- (UIView *)makeShadowWithColor: (UIColor *)shadowColor
                         radius: (CGFloat)shadowRadius
                        opacity: (CGFloat)shadowOpacity
                         offset: (CGSize)shadowOffset
                   cornerRadius: (CGFloat)cornerRadius
                         corner: (UIRectCorner)corner;

/**
 设置 maskLayer的边框

 @param lineWidth   边框的宽度
 @param borderColor 边框的颜色
 */
- (CAShapeLayer *)addMaskLayerWithLineWidth: (CGFloat)lineWidth
                                borderColor: (UIColor *)borderColor;

/**
 使用CAShapeLayer制作 圆角

 @param radius 圆角大小
 @param corner 指定的圆角
 @return 圆角的layer
 */
- (CAShapeLayer *)makeRadius: (CGFloat)radius corner: (UIRectCorner)corner;


/**
 创建阴影，不带有圆角。

 @param shadowColor   阴影的颜色
 @param shadowRadius  阴影的扩散半径
 @param shadowOpacity 阴影的透明度
 @return 阴影视图
 */
- (UIView *)makeSquartShadowWithColor: (UIColor *)shadowColor
                               radius: (CGFloat)shadowRadius
                              opacity: (CGFloat)shadowOpacity;

/**
 通过圆角，阴影属性创建阴影，并指定相应的圆角（推荐使用）

 @param attribute 圆角，阴影属性
 @return 阴影视图
 */
- (UIView *)makeShadowWithAttribute: (DYShadowAttribute *)attribute;


@end

@interface DYShadowAttribute : NSObject

@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) CGFloat  shadowRadius;
@property (nonatomic, assign) CGFloat  shadowOpacity;
@property (nonatomic, assign) CGSize   shadowOffset;

@property (nonatomic, assign) CGFloat      cornerRadius;
@property (nonatomic, assign) UIRectCorner corner;

@end

NS_ASSUME_NONNULL_END
