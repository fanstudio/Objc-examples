//
//  BasicTableViewCell.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/23.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "BasicTableViewCell.h"

@implementation BasicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame {
    // 指定每个cell之间的间距
    CGFloat space = 10;
    frame.origin.x = space;
    frame.origin.y += space * 0.5;
    frame.size.width -= 2 * space;
    frame.size.height -= space;
    
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
    }
    return self;
}

@end
