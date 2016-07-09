//
//  BaseViewController.h
//  01-masonry基本使用
//
//  Created by 张帆 on 16/6/13.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, copy) NSString *subTitle;

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                    viewClass:(Class)viewClass;

@end
