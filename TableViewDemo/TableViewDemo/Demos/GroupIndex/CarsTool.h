//
//  CarsTool.h
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarGroupItem.h"

@interface CarsTool : NSObject

@property (nonatomic, copy) NSString *imageBasePath;
@property (nonatomic, strong) NSArray <CarGroupItem *> *sections;

+ (instancetype)cars;

@end
