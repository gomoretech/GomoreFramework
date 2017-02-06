//
//  UIColor+Category.h
//  CXTools
//
//  Created by 曹云霄 on 16/9/22.
//  Copyright © 2016年 上海勾芒科技信息有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

/**
 *  RGB颜色
 *
 *  @param red   红色比例
 *  @param green 绿色比例
 *  @param blue  蓝色比例
 *  @param alpha 透明度
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue a:(CGFloat)alpha;

/**
 *  白色比例
 *
 *  @param white 白色比例
 *  @param alpha 透明度
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithW:(CGFloat)white a:(CGFloat)alpha;

/**
 *  16进制颜色
 *
 *  @param rgbValue 16进制
 *
 *  @return UIColor
 */
+ (UIColor *)colorFromHex:(int32_t)rgbValue;



+ (UIColor *)colorWithHexString: (NSString *)color;

@end
