//
//  DynamicCellDemoController.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/23.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "DynamicCellDemoController.h"
#import "DynamicCell.h"
#import "WBSBItem.h"

@interface DynamicCellDemoController ()
@property (nonatomic, strong) NSMutableArray <WBSBItem *> *data;
@property (nonatomic, copy) NSString *reuseId;
@end

@implementation DynamicCellDemoController

- (NSMutableArray<WBSBItem *> *)data {
    if (!_data) {
        _data = [WBSBItem array];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.reuseId = @"DynamicCell";
    UINib *nib = [UINib nibWithNibName:self.reuseId bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:self.reuseId];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseId];
    cell.item = self.data[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.onCellStatusChange = ^(DynamicCell *cell) {
        NSIndexPath *indexPath = [tableView indexPathForCell:cell];
        
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    };
    
    return cell;
}

@end
