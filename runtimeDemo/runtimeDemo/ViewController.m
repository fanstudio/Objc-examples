//
//  ViewController.m
//  runtimeDemo
//
//  Created by 张帆 on 16/7/27.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "MsgSend.h"
#import "Person.h"
#import "NSObject+extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demoRunTime];
}


#pragma mark -  __kindof 的使用

- (void)demoKindOf {
    Student *s = [Student person];
    NSLog(@"%@", s);
}


#pragma mark - runtime API使用
- (void)demoRunTime {
    // 1.使用runtime创建对象
    [MsgSend demoMsgSend];
    [self.view addSubview:[MsgSend aView]];
    
    /* 
     2.使用runtime更改原有方法步骤
     1）添加对应类的category
     2）在类仿佛load中，实现方法交换。
     3）实现方法体
     注意：使用不需要引用相应的头文件，在实现的过程中，
     可以选择initialize，但是交换只需要执行一次。
     */
    [UIImage imageNamed:@"aa"];
    
    /* 
     3.使用runtime动态添加方法
     1)在需要动态添加方法的类中重写+ (BOOL)resolveInstanceMethod:(SEL)sel;
     2)判断传入的SEL是否是需要执行的方法
     3）添加对应的映射关系
     4)使用performSelector:调用
     */
    Person *p = [Person new];
    [p performSelector:@selector(run)];
    [p performSelector:@selector(run:) withObject:@"哈哈"];
    
    /*
     4.利用runtime给系统类添加成员属性
     */
    NSObject *obj = [NSObject new];
    obj.name = @"test string";
    NSLog(@"%@", obj.name);
    
}


@end
