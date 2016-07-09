//
//  ContentScrollViewController.m
//  01-masonry基本使用
//
//  Created by 张帆 on 16/6/13.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

/*
 本节用于探讨控制器中automaticallyAdjustsScrollViewInsets对使用autolayout的影响。
 结论：
    1）与固定代码布局的方式一样，默认控制器的automaticallyAdjustsScrollViewInsets属性为YES
 添加在控制器view上的scrollView以及其派生类，在显示时如果有导航控制器会被切掉一部分。使显示的内容刚好
 能显示出来。
    
    2）在控制器上如果只添加scrollView以及派生类，如tableView等，应该将其frame与控制器的view.bounds一致。
    3）在控制器上如果有多个scrollView,这类控件，注意其显示的内容可能会被切掉一部分，下面的代码只验证了，
 在有导航栏时，其会影响第一个scrollView的显示内容，而第二个则不会。如果是这种情况。建议将automaticallyAdjustsScrollViewInsets设置为NO，然后根据具体的情况进行设置相应的Insets。
 */

#import "ContentScrollViewController.h"
#import "Masonry.h"

@interface ContentScrollViewController ()

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) UITextView *textView;

@end

@implementation ContentScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupWebView];
//    [self setupScrollView];
//    [self setupTextView];
}

- (void)setupWebView {
    UIWebView *webView = [UIWebView new];
    [self.view addSubview:webView];
    self.webView = webView;
    webView.backgroundColor = [UIColor greenColor];
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [webView setNeedsUpdateConstraints];
}



- (void)updateViewConstraints {
    __weak typeof(self) weakSelf = self;
    
    UIEdgeInsets edge = UIEdgeInsetsMake(74, 10, 10, 10);
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(edge);
    }];
    
    [super updateViewConstraints];
}


//- (void)setupScrollView {
//    UIScrollView *scrollView = [UIScrollView new];
//    [self.view addSubview:scrollView];
//    self.scrollView = scrollView;
//    [scrollView setNeedsUpdateConstraints];
//    scrollView.backgroundColor = [UIColor blueColor];
//    
//    UIView *view = [UIView new];
//    view.frame = CGRectMake(0, 0, 100, 44);
//    view.backgroundColor = [UIColor blackColor];
//    [scrollView addSubview:view];
//}
//
//
//- (void)setupTextView {
//    UITextView *textView = [UITextView new];
//    [self.view addSubview:textView];
//    self.textView = textView;
//    textView.backgroundColor = [UIColor redColor];
//    textView.text = @"这是一串测试文字，用于测试。。。。。。";
//    
//}
//
//- (void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//    
//    
//    self.scrollView.frame = CGRectMake(10, 74, self.view.frame.size.width - 20, 100);
//    self.textView.frame = CGRectMake(10, 184, self.view.frame.size.width - 20, 100);
//}


@end
