//
//  WBTextViewCellDemoController.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "WBTextViewCellDemoController.h"
#import "WBSBItem.h"
#import "WBTextViewCell.h"

@interface WBTextViewCellDemoController ()

@property (nonatomic, strong) NSMutableArray <WBSBItem *> *data;
@property (nonatomic, copy) NSString *reuseId;
@end

@implementation WBTextViewCellDemoController

- (NSMutableArray<WBSBItem *> *)data {
    if (!_data) {
        _data = [WBSBItem array];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.reuseId = @"WBTextViewCell";
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
    WBTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseId];
    cell.item = self.data[indexPath.row];
    
    return cell;
}

@end
