//
//  WBTextViewCell.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "WBTextViewCell.h"
#import "WBSBItem.h"

@interface WBTextViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation WBTextViewCell

- (void)awakeFromNib {
    // 使用self-sizing技术，UITextView等类似控件需要禁掉滚动
    self.contentTextView.scrollEnabled = NO;
    self.contentTextView.editable = NO;
}

- (void)setItem:(WBSBItem *)item {
    _item = item;
    
    self.iconImageView.image = [UIImage imageNamed:item.icon];
    self.contentTextView.text = item.text;
}
@end
