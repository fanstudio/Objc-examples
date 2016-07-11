//
//  Caculator.h
//  FunctionProgramDemo
//
//  Created by 张帆 on 16/7/11.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Caculator : NSObject

@property (nonatomic, assign) int result;
@property (nonatomic, assign) BOOL isEqual;

- (instancetype)add:(int (^)(int))callBack;
- (instancetype)isEeqaulZero:(BOOL(^)(int))callBack;

@end
