//
//  Caculator.m
//  CaculatorByChainCode
//
//  Created by 张帆 on 16/7/9.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "Caculator.h"


@implementation Caculator

/*
## 实现链式编程的要点：
    - 调用的方法的返回值是一个block类型的
    - 拿到方法体后，block的形参设计要与需求对应
    - block的返回值是对象本身
 
## 写法注意
block的声明写法跟C语言的回调函数在写法上还是有很大区别，如下
Caculator * (^callBack)(double)
(Caculator *)(*callBack)(double)
 
block的实现需要注意需要看是否有形参,有返回值需要在block中返回
^(形参类型1 形参1, 形参类型2 形参2) {
};
 
 */
- (Caculator * (^)(double))add {
    return ^(double num) {
        self.result += num;
        return self;
    };
}

@end
