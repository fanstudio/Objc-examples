//
//  MYKVONotifying_Person.m
//  ReactiveProgramDemo
//
//  Created by 张帆 on 16/7/11.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "MYKVONotifying_Person.h"
#import <objc/runtime.h>
#import "NSObject+MYKVO.h"

@implementation MYKVONotifying_Person

- (void)setAge:(int)age {
    [super setAge:age];
    
    id obServer = objc_getAssociatedObject(self, @"observer");
    if ([obServer respondsToSelector:@selector(my_observeValueForKeyPath:ofObject:value:)]) {
        [obServer my_observeValueForKeyPath:@"age" ofObject:obServer value:@(age)];
    }
}

@end
