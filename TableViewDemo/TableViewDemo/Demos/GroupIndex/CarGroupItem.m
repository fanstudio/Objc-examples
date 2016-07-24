//
//  CarGroupItem.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "CarGroupItem.h"

@implementation CarGroupItem

+ (instancetype)itemWithDic:(NSDictionary *)dic {
    CarGroupItem *item = [CarGroupItem new];
    item.title = dic[@"title"];
    
    NSMutableArray *cars = [NSMutableArray array];
    NSArray *originCars = dic[@"cars"];
    [originCars enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CarItem *car = [CarItem itemWithDic:obj];
        [cars addObject:car];
    }];
    item.cars = cars;
    
    return item;
}

@end
