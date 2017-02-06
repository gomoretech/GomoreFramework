//
//  NSBundle+Category.m
//  CXTools
//
//  Created by 曹云霄 on 2017/1/22.
//  Copyright © 2017年 上海勾芒科技信息有限公司. All rights reserved.
//

#import "NSBundle+Category.h"

@implementation NSBundle (Category)

/**
 *  获取icon的路径
 *
 *  @return 获得的路径
 */
- (NSString*)appIconPath {
    NSString* iconFilename = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"] ;
    NSString* iconBasename = [iconFilename stringByDeletingPathExtension] ;
    NSString* iconExtension = [iconFilename pathExtension] ;
    return [[NSBundle mainBundle] pathForResource:iconBasename
                                           ofType:iconExtension] ;
}

/**
 *  获取appIcon
 *
 *  @return 得到的iconImage
 */
- (UIImage*)appIcon {
    UIImage*appIcon = [[UIImage alloc] initWithContentsOfFile:[self appIconPath]] ;
    return appIcon;
}


@end
