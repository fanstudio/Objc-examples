//
//  DynamicCell.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/23.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "DynamicCell.h"
#import "WBSBItem.h"
#import "Masonry.h"

@interface DynamicCell ()
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIView *otherContentView;
@property (weak, nonatomic) IBOutlet UIView *seperatorView;
@property (weak, nonatomic) IBOutlet UILabel *moreTextLabel;

@end

@implementation DynamicCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (IBAction)onClick:(UIButton *)btn {
    // 状态反转
    self.item.vip = !self.item.vip;
    
    // 通知外界
    if (self.onCellStatusChange) {
        self.onCellStatusChange(self);
    }
}

- (void)setItem:(WBSBItem *)item {
    _item = item;
    
    self.actionButton.selected = item.vip;
    self.moreTextLabel.text = item.text;
    self.otherContentView.hidden = !item.vip;

    [self setNeedsUpdateConstraints];
}

- (BOOL)needsUpdateConstraints {
    return YES;
}
- (void)updateConstraints {
    if (self.item.vip) {
        [self.otherContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.top.equalTo(self.actionButton.mas_bottom).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.equalTo(self.seperatorView.mas_top).offset(-10);
        }];
    } else {
        [self.otherContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.top.equalTo(self.actionButton.mas_bottom).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.equalTo(self.seperatorView.mas_top).offset(-1);
            make.height.equalTo(@0);
        }];
    }
    
    [self layoutIfNeeded];
    
    [super updateConstraints];
}

@end
