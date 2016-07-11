//
//  ViewController.m
//  CaculatorByChainCode
//
//  Created by 张帆 on 16/7/9.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "ViewController.h"
#import "Caculator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Caculator *cac = Caculator.new;
    double res = cac.add(1).add(2).add(3).result;
    NSLog(@"%f", res);
}


@end
