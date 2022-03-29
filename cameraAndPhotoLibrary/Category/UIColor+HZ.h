//
//  UIColor+HZ.h
//  HangZhan
//
//  Created by ZK on 16/9/6.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HZ)

UIKIT_EXTERN NSString *const KEY_COLOR_WHITE;

/**
 *  根据RGB值返回颜色
 *
 *  @param red   R值    0 ~~ 255.0
 *  @param green G值    0 ~~ 255.0
 *  @param blue  B值    0 ~~ 255.0
 *  @param alpha 透明度    0 ~~ 1.0
 *
 *  @return RGB颜色
 */
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue alpha:(CGFloat)alpha;
/**
 *  根据RGB值返回颜色
 *
 *  @param red   R值    0 ~~ 255.0
 *  @param green G值    0 ~~ 255.0
 *  @param blue  B值    0 ~~ 255.0
 *
 *  @return RGB颜色
 */
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue;
/**
 *  从十六进制字符串获取颜色
 *
 *  @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *
 *  @return RGB颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color;
/**
 *  从十六进制字符串获取颜色
 *
 *  @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *  @param alpha 透明度    0 ~~ 1.0
 *
 *  @return RGB颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  背景色
 */
+ (UIColor *)colorOfBackgroudColor;
/**
 *  主色调红色
 */
+ (UIColor *)colorOfMain1Color;
/**
 *  主色调橘红
 */
+ (UIColor *)colorOfMain2Color;
/**
 *  主色调黑
 */
+ (UIColor *)colorOfMain3Color;
/**
 *  主色调蓝
 */
+ (UIColor *)colorOfMain4Color;
/**
 *  主色调黄
 */
+ (UIColor *)colorOfMain5Color;
/**
 *  主色调灰，比如轮播图的小圆点
 */
+ (UIColor *)colorOfMain6Color;
/**
 *  主色调蓝（按钮渐变色）
 */
+ (UIColor *)colorOfMain7Color;
/**
 *  主色调淡蓝（按钮渐变色）
 */
+ (UIColor *)colorOfMain8Color;

//按钮辅助色
+ (UIColor *)colorOfAuxiliaryColor;
//顶部导航标题色
+ (UIColor *)colorOfNavigateTextColor;
//系统消息详情背景色
+ (UIColor *)colorOfMessageBack;

/**
 *  线
 */
+ (UIColor *)colorOfLineColor;

@end
