//
//  CarItem.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "CarItem.h"

@implementation CarItem

+ (instancetype)itemWithDic:(NSDictionary *)dic {
    CarItem *car = [CarItem new];
    [car setValuesForKeysWithDictionary:dic];
    car.name = dic[@"name"];
    car.icon = dic[@"icon"];
    [car.icon stringByReplacingOccurrencesOfString:@"." withString:@"@2x."];
    return car;
}

@end
