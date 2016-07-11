//
//  Caculator.m
//  FunctionProgramDemo
//
//  Created by 张帆 on 16/7/11.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "Caculator.h"

@implementation Caculator

- (instancetype)add:(int (^)(int))callBack {
    self.result = callBack(self.result);
    return self;
}

- (instancetype)isEeqaulZero:(BOOL(^)(int))callBack {
    self.isEqual = callBack(self.result);
    return self;
}

@end
