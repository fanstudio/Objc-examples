//
//  NSObject+extension.m
//  runtimeDemo
//
//  Created by 张帆 on 16/7/27.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "NSObject+extension.h"
#import <objc/message.h>

@implementation NSObject (extension)

- (void)setName:(NSString *)name {
    /*
     参数说明：
     参数一：给哪个对象填加关联
     参数二：关联的键值
     参数三：关联的名称
     参数四：涉及内存管理的方式
     */
    objc_setAssociatedObject(self, "name", name, OBJC_ASSOCIATION_COPY);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, "name");
}

@end
