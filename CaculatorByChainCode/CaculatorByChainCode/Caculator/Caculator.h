//
//  Caculator.h
//  CaculatorByChainCode
//
//  Created by 张帆 on 16/7/9.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Caculator : NSObject

@property (nonatomic, assign) double result;

- (Caculator * (^)(double))add;

@end
