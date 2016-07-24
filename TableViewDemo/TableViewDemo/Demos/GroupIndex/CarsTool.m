//
//  CarsTool.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "CarsTool.h"

@implementation CarsTool

+ (instancetype)cars {
    CarsTool *tool = [self new];

    // 1.获取资源包
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Car" ofType:@"bundle"];
    NSBundle *resource = [NSBundle bundleWithPath:path];
    
    // 2.获取图片地址
    tool.imageBasePath = [resource pathForResource:@"images" ofType:nil];
    
    // 3.获取plist的原始数据
    NSMutableArray *data = [NSMutableArray array];
    NSString *plistPath = [resource pathForResource:@"cars.plist" ofType:nil];
    NSArray *orignData = [NSArray arrayWithContentsOfFile:plistPath];
    [orignData enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CarGroupItem *groupItem = [CarGroupItem itemWithDic:obj];
        [data addObject:groupItem];
    }];
    tool.sections = data;
    
    return tool;
}

@end
