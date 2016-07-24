//
//  DemoBaseController.h
//  TableViewDemo
//
//  Created by 张帆 on 16/7/19.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoBaseController : UITableViewController

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;


@end
