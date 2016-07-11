//
//  DelegateTestView.m
//  RACTest
//
//  Created by 张帆 on 16/7/10.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "DelegateTestView.h"

@interface DelegateTestView ()


@end

@implementation DelegateTestView

+ (instancetype)view {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
}


- (IBAction)onClick:(id)sender {
    NSLog(@"%s", __func__);
}

@end
