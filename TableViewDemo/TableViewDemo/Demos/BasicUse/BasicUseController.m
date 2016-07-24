//
//  BasicUseController.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "BasicUseController.h"
#import "BasicTableViewCell.h"


/**********************************************************************/

@interface DemoItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;

+ (instancetype)itemWithTile:(NSString *)title
                    subTitle:(NSString *)subTitle;

@end

@implementation DemoItem

+ (instancetype)itemWithTile:(NSString *)title
                    subTitle:(NSString *)subTitle {
    DemoItem *it = [DemoItem new];
    it.title = title;
    it.subTitle = subTitle;
    return it;
}

@end
/**********************************************************************/

@interface BasicUseController ()

@property (nonatomic, strong) NSMutableArray <DemoItem *> *items;

@end

@implementation BasicUseController


- (NSMutableArray<DemoItem *> *)items {
    if (!_items) {
        _items = [NSMutableArray array];
        for (NSInteger idx = 0; idx < 50; idx++) {
            DemoItem *item = [DemoItem itemWithTile:[NSString stringWithFormat:@"标题--%02ld", idx]
                                           subTitle:[NSString stringWithFormat:@"子标题--%02ld", idx]];
            [_items addObject:item];
        }
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor lightGrayColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"BasicTableViewCell";
    BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BasicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.items[indexPath.row].title;
    cell.detailTextLabel.text = self.items[indexPath.row].subTitle;
    
    return cell;
}

@end
