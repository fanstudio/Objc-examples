//
//  WBSBItem.h
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBSBItem : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) BOOL vip;
@property (nonatomic, copy) NSString *picture;

+ (instancetype)itemWithDic:(NSDictionary *)dic;

+ (NSMutableArray <WBSBItem *> *)array;

@end
