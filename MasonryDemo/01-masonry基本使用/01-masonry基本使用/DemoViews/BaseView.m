//
//  BaseView.m
//  01-masonry基本使用
//
//  Created by 张帆 on 16/6/13.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "BaseView.h"
#import "Masonry.h"

@interface BaseView ()

@property (nonatomic, weak) UIView *contentView;


@end

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    [self setupSubView];
    
    return self;
}


/*
 看到很多Autolayout写的自定义控件中都实现了+requiresConstraintBasedLayout方法，
 一直不知道这个方法有什么用，因为不实现这个方法也没发现有什么影响。经过查找资料，有解释如下：
 
 constraint-based layout engages lazily when someone tries to use it (e.g., adds a constraint to a view). 
 If you do all of your constraint set up in -updateConstraints, you might never even receive updateConstraints if no one makes a constraint. To fix this chicken and egg problem, override this method to return YES if your view needs the window to use constraint-based layout.
 
 意思就是基于约束的布局是懒触发的，只有在添加了约束的情况下，系统才会自动调用 -updateConstraints 方法，
 如果把所有的约束放在 updateConstraints中，那么系统将会不知道你的布局方式是基于约束的，所以 重写+requiresConstraintBasedLayout 返回YES就是明确告诉系统：虽然我之前没有添加约束,但我确实是基于
 约束的布局！这样可以保证系统一定会调用 -updateConstraints 方法 从而正确添加约束.
 
 文／fallrainy（简书作者）
 原文链接：http://www.jianshu.com/p/ef6b6578148d
 著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。
 */
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)setupSubView {
    UIView *contentView = UIView.new;
    [self addSubview:contentView];
    contentView.backgroundColor = [UIColor redColor];
    self.contentView = contentView;
    
    NSLog(@"%s", __func__);
}

- (void)updateConstraints {
    NSLog(@"%s", __func__);
    CGFloat padding = 10;
    __weak typeof(self) weakSelf = self;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(74);
        make.right.equalTo(weakSelf.mas_right).offset(-padding);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-padding);
        make.left.equalTo(weakSelf.mas_left).offset(padding);

    }];
    
   [super updateConstraints];
 
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"%s", __func__);
}

@end
