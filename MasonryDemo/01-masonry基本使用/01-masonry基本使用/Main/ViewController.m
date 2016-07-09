//
//  ViewController.m
//  01-masonry基本使用
//
//  Created by 张帆 on 16/6/13.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"
#import "AutoLayoutTestController.h"
#import "ContentScrollViewController.h"
#import "BaseView.h"
#import "ThreeSplitView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray <BaseViewController *> *vcs;

@end

@implementation ViewController

- (NSArray *)vcs {
    if (_vcs) return _vcs;
    
    _vcs = @[
             [[BaseViewController alloc] initWithTitle:@"基本使用" subTitle:@"在view中使用" viewClass:BaseView.class],
             [[BaseViewController alloc] initWithTitle:@"三等分" subTitle:@"上下等分，左右等分" viewClass:ThreeSplitView.class],
             [[AutoLayoutTestController alloc] initWithTitle:@"控制器中添加UIView" subTitle:@"在控制器中使用autoLayout,目前还有警告" viewClass:nil],
             [[ContentScrollViewController alloc] initWithTitle:@"控制器中添加webView" subTitle:@"注意控制器automaticallyAdjustsScrollViewInsets的影响" viewClass:nil],

    ];
    
    
    return _vcs;
}

- (void)loadView {
    UITableView *tableView = UITableView.new;
    tableView.dataSource = self;
    tableView.delegate = self;
    self.view = tableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"布局练习";
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseViewController *vc = self.vcs[indexPath.row];
    
    NSString *ID = NSStringFromClass(UITableViewCell.class);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = vc.title;
    cell.detailTextLabel.text = vc.subTitle;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseViewController *vc = self.vcs[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
