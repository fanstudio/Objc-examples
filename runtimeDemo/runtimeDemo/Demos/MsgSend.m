//
//  MsgSend.m
//  ios9FeaturesDemo
//
//  Created by 张帆 on 16/7/25.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "MsgSend.h"
#import <objc/message.h>

@implementation MsgSend

+ (void)demoMsgSend {
    /* 
     使用runtime方法创建一个NSObject对象
     xcode6之后，苹果不推荐使用runtime。
     为了更好地使用runtime API的提示，可以在工程的build setting->搜索“msg”->NO
     */
    NSObject *obj = objc_msgSend(NSObject.class, @selector(alloc));
    objc_msgSend(obj, @selector(init));
    NSLog(@"%@", obj);
    
    
    NSObject *otherObj = objc_msgSend(objc_getClass("NSObject"), sel_registerName("alloc"));
    objc_msgSend(otherObj, sel_registerName("init"));
    NSLog(@"%@", otherObj);
    
}

+ (UIView *)aView {
    UIView *view = objc_msgSend(objc_getClass("UIView"), sel_registerName("alloc"));
    objc_msgSend(view, sel_registerName("initWithFrame:"), CGRectMake(0, 0, 100, 100));
    view.backgroundColor = [UIColor redColor];
    
    return view;
}

@end
