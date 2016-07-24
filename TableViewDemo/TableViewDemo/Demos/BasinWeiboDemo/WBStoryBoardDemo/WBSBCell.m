//
//  WBSBCell.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "WBSBCell.h"
#import "WBSBItem.h"

@interface WBSBCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImageBottom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImageViewHeight;
@end

@implementation WBSBCell

- (void)awakeFromNib {
    self.vipImageView.image = [UIImage imageNamed:@"vip"];
}

- (void)setItem:(WBSBItem *)item {
    _item = item;
    
    // 1.
    self.iconImageView.image = [UIImage imageNamed:item.icon];
   
    // 2.
    if (item.vip) {
        self.nickNameLabel.textColor = [UIColor redColor];
    } else {
        self.nickNameLabel.textColor = [UIColor blackColor];
    }
    self.nickNameLabel.text = item.name;
    
    // 3.
    self.vipImageView.hidden = !item.vip;

    // 4.
    self.contentTextLabel.text = item.text;
    
    // 5.
    if (item.picture) {
        self.contentImageBottom.constant = 9;
        self.contentImageViewHeight.constant = 60;
        self.contentImageView.hidden = NO;
        self.contentImageView.image = [UIImage imageNamed:item.picture];
    } else {
        self.contentImageView.hidden = YES;
        self.contentImageBottom.constant = 0;
        self.contentImageViewHeight.constant = 0;
    }
    
}

@end
