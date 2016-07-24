//
//  WBStoryBoardController.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "WBStoryBoardController.h"
#import "WBSBItem.h"
#import "WBSBCell.h"

@interface WBStoryBoardController ()

@property (nonatomic, strong) NSMutableArray <WBSBItem *> *data;

@end

@implementation WBStoryBoardController

- (NSMutableArray<WBSBItem *> *)data {
    if (!_data) {
        _data = [WBSBItem array];
    }
    return _data;
}

+ (instancetype)vcWithName:(NSString *)name {
    WBStoryBoardController *vc = [[UIStoryboard storyboardWithName:@"WBStoryBoardController" bundle:nil] instantiateInitialViewController];
    vc.name = name;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 163;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBSBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBSBCell"];
    cell.item = self.data[indexPath.row];
    
    return cell;
}


@end
