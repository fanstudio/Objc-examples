//
//  ViewController.m
//  FunctionProgramDemo
//
//  Created by 张帆 on 16/7/11.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "ViewController.h"
#import "Caculator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 函数式编程特点：
        每个方法必须有返回值（本身对象）,把函数或者Block当做参数,block参数（需要操作的值）block返回值（操作结果）
     练习:
        用函数式编程实现，写一个加法计算器,并且加法计算器自带判断是否等于某个值.
    */
    
    Caculator *cal = [Caculator new];
    BOOL res = [[[cal add:^int(int res) {
        return res + 1;
    }] isEeqaulZero:^BOOL(int res) {
        return res == 0;
    }] isEqual];
    
    NSLog(@"%d", res);
}

@end
