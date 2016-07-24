//
//  ViewController.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/19.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "ViewController.h"
#import "BasicUseController.h"
#import "GroupIndexDemoController.h"
#import "WBStoryBoardController.h"
#import "WBTextViewCellDemoController.h"
#import "DynamicCellDemoController.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *reuseId;
@property (nonatomic, strong) NSArray <DemoBaseController *> *demos;

@end

@implementation ViewController

- (NSArray<DemoBaseController *> *)demos {
    if (!_demos) {
        // 在此添加需要展示的实例
        _demos = @[
                   [[BasicUseController alloc] initWithName:@"等高cell-卡片式cell"],
                   [[GroupIndexDemoController alloc] initWithName:@"等高cell-sectionIndex使用"],
                   [WBStoryBoardController vcWithName:@"非等高cell-storyboard方式实现"],
                   [[WBTextViewCellDemoController alloc] initWithName:@"非等高cell-含textView"],
                   [[DynamicCellDemoController alloc] initWithName:@"非等高cell-动态(展开/收拢)"],
                   ];
    }
    return _demos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"tableView使用实例";

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // 小技巧，清空没有内容的分割线
    self.tableView.tableFooterView = [UIView new];

    // 注册重复利用cell
    self.reuseId = NSStringFromClass(UITableViewCell.class);
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:self.reuseId];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseId];
    cell.textLabel.text = self.demos[indexPath.row].name;

    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoBaseController *vc = self.demos[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
