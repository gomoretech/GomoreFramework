//
//  NSArray+Category.m
//  CXTools
//
//  Created by 曹云霄 on 16/9/22.
//  Copyright © 2016年 上海勾芒科技信息有限公司. All rights reserved.
//

#import "NSArray+Category.h"

@implementation NSArray (Category)

- (id)yx_objectAtIndex:(NSUInteger)index
{
    if (index > self.count) {
        return nil;
    }else
    {
        return [self objectAtIndex:index];
    }
}

- (NSArray *)arrayFromPlistName:(NSString *)plistName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:path];
}

@end
