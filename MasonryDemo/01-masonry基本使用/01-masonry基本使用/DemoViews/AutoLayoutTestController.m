//
//  AutoLayoutTestController.m
//  01-masonry基本使用
//
//  Created by 张帆 on 16/6/13.
//  Copyright © 2016年 fanstudio. All rights reserved.
//


/**
 一、本节需要探讨在自定义控制器中添加约束的位置
 二、以及使用Masonry时应该是使用mas_makeConstraints，还是mas_updateConstraints
 
 */

#import "AutoLayoutTestController.h"
#import "Masonry.h"

@interface AutoLayoutTestController ()

@property (nonatomic, weak) UIView *contentView;

@end

@implementation AutoLayoutTestController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UIView *contentView = [UIView new];
    [self.view addSubview:contentView];
    self.contentView = contentView;
    self.contentView.backgroundColor = [UIColor grayColor];
    
    [contentView setNeedsUpdateConstraints];
    
}


- (void)updateViewConstraints {
    __weak typeof(self) weakSelf = self;
    
    CGFloat topPadding = 10;
    if (self.navigationController != nil) {
        topPadding += 64;
    }
    UIEdgeInsets edge = UIEdgeInsetsMake(topPadding, 10, 10, 10);
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(edge);
    }];
    
    [super updateViewConstraints];
}

@end
