//
//  UIImage+Category.h
//  CXTools
//
//  Created by 曹云霄 on 16/9/22.
//  Copyright © 2016年 上海勾芒科技信息有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)



/**
 *  通过viewsize来压缩图片
 *
 *  @param image    UIImage
 *  @param viewsize 理想Size
 *
 *  @return 调整后的image
 */
+ (UIImage *)image:(UIImage *)image fitInSize:(CGSize)viewsize;

/**
 *  由颜色生成图片
 *
 *  @param color UIColor
 *
 *  @return image
 */
+ (UIImage *) imageWithColor:(UIColor*)color;

/**
 *  将图片剪裁至目标尺寸
 *
 *  @param sourceImage image
 *  @param targetSize  理想size
 *
 *  @return image
 */
+ (UIImage *) imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize;

/*
 * 添加图片水印
 */
- (UIImage *)watermarkImage:(NSString *)text;

/**
 *  图片旋转角度
 *
 *  @param degrees 角度
 *
 *  @return image
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 *  拉伸图片CGFloat
 *
 *  @param scale 拉伸比例
 *
 *  @return image
 */
- (UIImage *)imageByResizeToScale:(CGFloat)scale;

/**
 *  放大图片CGSize
 *
 *  @param size 理想size
 *
 *  @return image
 */
- (UIImage *)imageByResizeWithMaxSize:(CGSize)size;

/**
 * 生成缩略图
 *
 *  @param size 理想size
 *
 *  @return image
 */
- (UIImage *)imageWithThumbnailForSize:(CGSize)size;

/**
 *  通过Rect剪裁图片
 *
 *  @param rect 理想矩阵
 *
 *  @return image
 */
- (UIImage *)imageByCropToRect:(CGRect)rect;

/**
 *  图片增加圆角
 *
 *  @param radius 圆角系数
 *
 *  @return image
 */
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius;

/**
 *  图片增加圆角及边框
 *
 *  @param radius      圆角系数
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return image
 */
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                           borderWidth:(CGFloat)borderWidth
                           borderColor:(UIColor *)borderColor;

/**
 *  图片向左90度
 *
 *  @return image
 */
- (UIImage *)imageByRotateLeft90;

/**
 *  图片向右90度
 *
 *  @return image
 */
- (UIImage *)imageByRotateRight90;

/**
 *  图片转180度
 *
 *  @return image
 */
- (UIImage *)imageByRotate180;

/**
 *  图片呈玻璃化柔色
 *
 *  @return image
 */
- (UIImage *)imageByBlurSoft;

/**
 *  图片呈玻璃化亮色
 *
 *  @return image
 */
- (UIImage *)imageByBlurLight;

/**
 *  图片呈玻璃化高亮色
 *
 *  @return image
 */
- (UIImage *)imageByBlurExtraLight;

/**
 *  图片呈玻璃化黑色
 *
 *  @return image
 */
- (UIImage *)imageByBlurDark;

/**
 *  图片呈玻璃化（tintColor颜色）
 *
 *  @param tintColor 理想的颜色
 *
 *  @return image
 */
- (UIImage *)imageByBlurWithTint:(UIColor *)tintColor;




@end
