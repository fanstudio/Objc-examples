//
//  DynamicCell.h
//  TableViewDemo
//
//  Created by 张帆 on 16/7/23.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBSBItem;

@interface DynamicCell : UITableViewCell

@property (nonatomic, strong) WBSBItem *item;

@property (nonatomic, copy) void (^onCellStatusChange)(DynamicCell *);

@end
