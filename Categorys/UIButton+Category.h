//
//  UIButton+Category.h
//  CXTools
//
//  Created by 曹云霄 on 16/9/23.
//  Copyright © 2016年 上海勾芒科技信息有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

/*****************************跳转图片和文字的位置*****************************/
//上下居中，图片在上，文字在下
- (void)verticalCenterImageAndTitle:(CGFloat)spacing;

//左右居中，文字在左，图片在右
- (void)horizontalCenterTitleAndImage:(CGFloat)spacing;

//左右居中，图片在左，文字在右
- (void)horizontalCenterImageAndTitle:(CGFloat)spacing;

//文字居中，图片在左边
- (void)horizontalCenterTitleAndImageLeft:(CGFloat)spacing;

//文字居中，图片在右边
- (void)horizontalCenterTitleAndImageRight:(CGFloat)spacing;


@end
