//
//  BaseViewController.m
//  01-masonry基本使用
//
//  Created by 张帆 on 16/6/13.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, strong) Class viewClass;
@end

@implementation BaseViewController

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                    viewClass:(Class)viewClass {
    self = [super init];
    if (!self) return nil;
    
    self.title = title;
    self.subTitle = subTitle;
    self.viewClass = viewClass;
    
    return self;
}

- (void)loadView {
    if (self.viewClass) {
        self.view = self.viewClass.new;
    } else {
        self.view = [UIView new];
        self.view.backgroundColor = [UIColor whiteColor];
    }
}



@end
