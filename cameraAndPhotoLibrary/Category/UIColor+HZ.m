//
//  UIColor+HZ.m
//  HangZhan
//
//  Created by ZK on 16/9/6.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "UIColor+HZ.h"

@implementation UIColor (HZ)

NSString *const KEY_COLOR_WHITE = @"#ffffff";


+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    //alpha
    NSString *aString;
    if (cString.length == 8) {
        NSRange range;
        range.location = 2;
        range.length = 0;
        aString = [cString substringWithRange:range];
        //r
        range.length = 2;
        rString = [cString substringWithRange:range];
        //g
        range.location = 4;
        gString = [cString substringWithRange:range];
        //b
        range.location = 6;
        bString = [cString substringWithRange:range];
        unsigned int r, g, b, a;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:(float)(a/255.0f)];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

//背景色
+ (UIColor *)colorOfBackgroudColor{
    
    return [UIColor colorWithRed:0.93 green:0.93 blue:0.96 alpha:1.00];
}
//主色调
+ (UIColor *)colorOfMain1Color{
    return [UIColor colorWithHexString:@"#ff4948"];
}
//主色调
+ (UIColor *)colorOfMain2Color{
    return [UIColor colorWithHexString:@"#fc6c3a"];
}
//主色调
+ (UIColor *)colorOfMain3Color{
    return [UIColor colorWithHexString:@"#000000"];
}
//主色调蓝
+ (UIColor *)colorOfMain4Color{
    return [UIColor colorWithHexString:@"#1e88e5"];
}
//主色调黄
+ (UIColor *)colorOfMain5Color{
    return [UIColor colorWithHexString:@"#ffca28"];
}
//主色调灰，比如轮播图的小圆点
+ (UIColor *)colorOfMain6Color{
    return [UIColor colorWithHexString:@"#a5aab2"];
}
//主色调蓝（按钮渐变色）
+ (UIColor *)colorOfMain7Color{
    return [UIColor colorWithHexString:@"#1e74f0"];
}
//主色调淡蓝（按钮渐变色）
+ (UIColor *)colorOfMain8Color{
    return [UIColor colorWithHexString:@"#1cc5fe"];
}

//按钮辅助色
+ (UIColor *)colorOfAuxiliaryColor{
    return [UIColor colorWithHexString:@"#5b7fd1"];
}
//顶部导航标题色
+ (UIColor *)colorOfNavigateTextColor{
    return [UIColor colorWithHexString:@"#405d9f"];
}

//系统消息详情背景色
+ (UIColor *)colorOfMessageBack{
    return [UIColor colorWithHexString:@"#F9F9F9"];
}
//线
+ (UIColor *)colorOfLineColor{
    return [UIColor colorWithHexString:@"#E4E5E6"];
}


@end
