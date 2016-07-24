//
//  CarItem.h
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarItem : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;

+ (instancetype)itemWithDic:(NSDictionary *)dic;

@end
