//
//  ThreeSplitView.m
//  01-masonry基本使用
//
//  Created by 张帆 on 16/6/13.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "ThreeSplitView.h"
#import "Masonry.h"

@interface ThreeSplitView ()

@property (nonatomic, weak) UIView *leftView;
@property (nonatomic, weak) UIView *rightView;
@property (nonatomic, weak) UIView *bottomView;

@end


@implementation ThreeSplitView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    [self setupSubView];
    
    return self;
}

- (void)setupSubView {
    UIView *leftView = UIView.new;
    [self addSubview:leftView];
    leftView.backgroundColor = [UIColor redColor];
    self.leftView = leftView;
    
    UIView *rightView = [UIView new];
    [self addSubview:rightView];
    rightView.backgroundColor = [UIColor greenColor];
    self.rightView = rightView;
    
    UIView *bottomView = [UIView new];
    [self addSubview:bottomView];
    bottomView.backgroundColor = [UIColor blueColor];
    self.bottomView = bottomView;
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    
    CGFloat padding = 10;
    __weak typeof(self) weakSelf = self;
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(padding);
        make.right.equalTo(weakSelf.rightView.mas_left).offset(-padding);
        make.bottom.equalTo(weakSelf.bottomView.mas_top).offset(-padding);
        make.left.equalTo(weakSelf.mas_left).offset(padding);
        
        make.width.equalTo(weakSelf.rightView.mas_width);
        make.height.equalTo(weakSelf.bottomView.mas_height);
    }];
    
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(padding);
        make.right.equalTo(weakSelf.mas_right).offset(-padding);
        make.bottom.equalTo(weakSelf.bottomView.mas_top).offset(-padding);
        make.left.equalTo(weakSelf.leftView.mas_right).offset(padding);
        
        make.width.equalTo(weakSelf.leftView.mas_width);
        make.height.equalTo(weakSelf.bottomView.mas_height);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.rightView.mas_bottom).offset(padding);
        make.right.equalTo(weakSelf.mas_right).offset(-padding);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-padding);
        make.left.equalTo(weakSelf.mas_left).offset(padding);
        
        make.height.equalTo(weakSelf.rightView.mas_height);
    }];
    
    
    
    [super updateConstraints];
}
@end
