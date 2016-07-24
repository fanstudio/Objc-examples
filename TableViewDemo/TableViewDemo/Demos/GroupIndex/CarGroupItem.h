//
//  CarGroupItem.h
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarItem.h"

@interface CarGroupItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray <CarItem *> *cars;

+ (instancetype)itemWithDic:(NSDictionary *)dic;

@end
