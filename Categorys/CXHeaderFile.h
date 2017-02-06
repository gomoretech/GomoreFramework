//
//  CXHeaderFile.h
//  CXTools
//
//  Created by 曹云霄 on 16/9/22.
//  Copyright © 2016年 上海勾芒科技信息有限公司. All rights reserved.
//

#ifndef CXHeaderFile_h
#define CXHeaderFile_h




/**
 *  Documents路径
 */
#define kPathDocument  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/**
 *  caches路径
 */
#define kPathCaches  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/**
 *  NSLibraryDirectory路径
 */
#define kPathLibiary  [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]


/**
 * 读取本地图片路径
 */
#define LOADIMAGE(fileName) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:nil]]

/*
 * Clog
 */
#ifdef DEBUG
#define CLog(format, ...) NSLog((@"[Line %d] %s " format), __LINE__, __PRETTY_FUNCTION__, ## __VA_ARGS__)
#else
#define CLog(format, ...)
#endif

/**
 *  RGB颜色
 */
#define RGBA(R,G,B,A)   [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

/**
 *  字体大小
 */
#define FontSize(num)    [UIFont systemFontOfSize:num]

/**
 *  keyWindow
 */
#define AppWindow      [[UIApplication sharedApplication].delegate window]

/**
 *  物理屏幕Size
 */
#define ScreenSize       ([[UIScreen mainScreen] bounds].size)


/**
 *  设备信息
 */
#define Device          [UIDevice currentDevice]



















#endif /* CXHeaderFile_h */
