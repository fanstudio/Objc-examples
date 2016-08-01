//
//  Person.m
//  ios9FeaturesDemo
//
//  Created by 张帆 on 16/7/25.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person

+ (instancetype)person {
    return [self new];
}

/*
 1. __kindof 的使用能更友好表示返回的值类型
 2.在类方法中不要写死是哪种类型，而应该写成self
 否则子类继承后创建出来的只会是父类
 */
+ (__kindof Person*)aPerson {
    return [self new];
}


#pragma mark - runtime动态添加方法

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (NSSelectorFromString(@"run") == sel) {
        /*
         class_addMethod(Class cls, SEL name, IMP imp, const char *types)
         cls - 为哪个类或者对象添加方法
         name - 添加的方法名称
         imp - 实现该方法的函数名
         types - 表示该函数的返回值，形参列表
         
         注意：形参列表的写法比较BT，比如v表示void,@表示对象，:表示selector
         参阅文档-》Languages & utilities -》objective-c -》objective-c runtime programming guide -》type encodings
         */
        class_addMethod(self, sel, (IMP)runFunction, "v@:");
        return YES;
    }
    
    if (sel == NSSelectorFromString(@"run:")) {
        class_addMethod(self, sel, (IMP)runWithArg, "v@:@");
        return  YES;
    }
    
    return [super resolveInstanceMethod:sel];
}


void runFunction(id obj, SEL sel) {
    printf("%p %p\n", obj, sel);
}

void runWithArg(id obj, SEL sel, id arg) {
    NSLog(@"%@", arg);
}


@end
