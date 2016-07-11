//
//  NSObject+MYKVO.m
//  ReactiveProgramDemo
//
//  Created by 张帆 on 16/7/11.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "NSObject+MYKVO.h"
#import "MYKVONotifying_Person.h"
#import <objc/runtime.h>

@implementation NSObject (MYKVO)

- (void)my_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {

    // 1.修改isa,本质就是改变当前对象的类名
    object_setClass(self, [MYKVONotifying_Person class]);
    
    /* 2.给当前对象添加一个属性，并把观察者保存到当前对象里
     OBJC_EXPORT void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
     
     object - 要增加的属性的对象
     key - 属性的名称
     value - 属性的值
     policy - 值创建的方式，这里是个枚举值，
     个人理解为 @property (nonatomic, policy) key value
     */
    
    objc_setAssociatedObject(self, @"observer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)my_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object value:(id)value {
}

@end
