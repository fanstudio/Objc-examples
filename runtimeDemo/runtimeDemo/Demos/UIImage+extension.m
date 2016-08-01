//
//  UIImage+extension.m
//  ios9FeaturesDemo
//
//  Created by 张帆 on 16/7/27.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "UIImage+extension.h"
#import <objc/message.h>

@implementation UIImage (extension)

/*
 ==================使用runtime实现下面的功能==============
 
+ (UIImage *)fz_imageNamed:(NSString *)name {
    UIImage * image = [self imageNamed:name];
    if (image) {
        NSLog(@"图片加载成功");
    } else {
        NSLog(@"图片加载失败");
    }

    return image;
}
 ======================================================
 */

+ (void)load {

    Method m1 = class_getClassMethod(self, @selector(imageNamed:));
    Method m2 = class_getClassMethod(self, @selector(fz_imageNamed:));
    
    /* 
     注意：执行下面的方法后，UIImage调用imageNamed:会变成fz_imageNamed:
     调用fz_imageNamed:会变成调用imageNamed:
    */
    method_exchangeImplementations(m1, m2);
}

+ (UIImage *)fz_imageNamed:(NSString *)name {
    UIImage * image = [self fz_imageNamed:name];
    if (image) {
        NSLog(@"图片加载成功");
    } else {
        NSLog(@"图片加载失败");
    }
    return image;
}

@end
