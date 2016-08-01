//
//  NSObject+extension.h
//  runtimeDemo
//
//  Created by 张帆 on 16/7/27.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (extension)

// category中property只会创建对应方法的申明,不会生成带下划线的成员变量
@property NSString *name;

@end
