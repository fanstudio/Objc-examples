//
//  DemoBaseController.m
//  TableViewDemo
//
//  Created by 张帆 on 16/7/19.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "DemoBaseController.h"


@implementation DemoBaseController

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.name;
}



@end
