//
//  WBSBItem.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "WBSBItem.h"

@implementation WBSBItem

+ (instancetype)itemWithDic:(NSDictionary *)dic {
    WBSBItem *item = [self new];
    [item setValuesForKeysWithDictionary:dic];
    
    return item;
}

+ (NSMutableArray <WBSBItem *> *)array {
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"statuses.plist" ofType:nil];
    NSArray *arr = [NSArray arrayWithContentsOfFile:resourcePath];
    
    NSMutableArray *data = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [data addObject:[WBSBItem itemWithDic:obj]];
    }];
    
    return data;
}

@end
