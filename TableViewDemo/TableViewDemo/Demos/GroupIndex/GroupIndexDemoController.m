//
//  GroupIndexDemoController.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "GroupIndexDemoController.h"
#import "CarsTool.h"

@interface GroupIndexDemoController ()

@property (nonatomic, strong) CarsTool *resource;
@property (nonatomic, copy) NSString *cellReuseId;

@end

@implementation GroupIndexDemoController

- (CarsTool *)resource {
    if (!_resource) {
        _resource = [CarsTool cars];
    }
    return _resource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cellReuseId = NSStringFromClass(UITableViewCell.class);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.cellReuseId];
    self.tableView.sectionIndexColor = [UIColor whiteColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor darkGrayColor];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.resource.sections.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.resource.sections[section].title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resource.sections[section].cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellReuseId];
    CarItem * car = self.resource.sections[indexPath.section].cars[indexPath.row];

    NSString *imagePath = [NSString stringWithFormat:@"%@/%@", self.resource.imageBasePath, car.icon];
    cell.imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    cell.textLabel.text = car.name;
    
    return cell;
}


- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.resource.sections mutableArrayValueForKeyPath:@"title"];
}

@end
