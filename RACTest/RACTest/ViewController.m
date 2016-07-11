//
//  ViewController.m
//  RACTest
//
//  Created by 张帆 on 16/7/10.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "ViewController.h"
#import "DelegateTestView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface ViewController ()

@property (nonatomic, assign) int num;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self racRepleaceDelegate];
//    [self racReplaceKVO];
//    [self racReplaceEvent];
//    [self racReplaceNSNotification];
//    [self racActionGroupSignal];
//    [self testMacro];
    [self testBasicFunction];
}

// 1.使用RAC替换代理设计
- (void)racRepleaceDelegate {
    DelegateTestView *delegateView = [DelegateTestView view];
    [self.view addSubview:delegateView];
    delegateView.frame = CGRectMake(10, 10, 100, 50);
    
    __weak typeof(self) weakSelf = self;
    [[delegateView rac_signalForSelector:@selector(onClick:)] subscribeNext:^(id x) {
        NSLog(@"事件被执行后调用后执行的代码 %@", x);
        weakSelf.num++;
    }];
}

// 2.使用RAC替代KVO的使用
- (void)racReplaceKVO {
    [[self rac_valuesForKeyPath:@"num" observer:nil] subscribeNext:^(id x) {
        NSLog(@"值发生改变时执行 %@", x);
    }];
}

// 3.使用RAC替代事件处理
- (void)racReplaceEvent {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:button];
    button.center = CGPointMake(130, 40);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"事件处理");
    }];
}

// 4.使用rac的通知处理更简单
- (void)racReplaceNSNotification {
    UITextField *textField = [UITextField new];
    [self.view addSubview:textField];
    textField.frame = CGRectMake(10, 80, 300, 44);
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.layer.borderWidth = 1.0;
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"UIKeyboardWillShowNotification");
    }];

    [self racExtendSignal:textField];
}

// 5.使用RAC扩展的文字信号，监听文字改变，更简单
- (void)racExtendSignal:(UITextField *)textFiled {
    [textFiled.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"当前文字为:%@", x);
    }];
}

// 6.使用RAC聚合处理一组信号，当所有的信号都产生时才执行相应的方法
- (void)racActionGroupSignal {
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"准备产生事件一");
        [subscriber sendNext:@"事件一产生"];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSLog(@"准备产生事件二");
        [subscriber sendNext:@"事件二产生"];
        return nil;
        
    }];
    
    // 使用注意：事件处理的方法参数必须同监听的信号数量一致，否则会报错
    [self rac_liftSelector:@selector(onGroupSignalHappen:otherMsg:) withSignalsFromArray:@[signalA, signalB]];
}


- (void)onGroupSignalHappen:(id)msg otherMsg:(id)otherMsg {
    NSLog(@"%@ %@", msg, otherMsg);
}

// 7.RAC常见的宏
- (void)testMacro {
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    label.frame = CGRectMake(10, 130, 300, 44);
    label.backgroundColor = [UIColor darkGrayColor];
    
    UITextField *textFiled = [UITextField new];
    [self.view addSubview:textFiled];
    textFiled.frame = CGRectMake(10, CGRectGetMaxY(label.frame), 300, 44);
    textFiled.backgroundColor = [UIColor grayColor];
    

    /*
     7.1 RAC 值绑定宏
     用于给某个对象的某个属性绑定相应的值，等价于下面的代码
     [textFiled.rac_textSignal subscribeNext:^(id x) {
         label.text = x;
     }];
     */
    RAC(label, text) = textFiled.rac_textSignal;
    
    // 7.2 KVO宏
    [RACObserve(self, num) subscribeNext:^(id x) {
        NSLog(@"self.num = %@", x);
    }];
    
    // 7.3 解决循环引用
    @weakify(self);
    [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        // 这下面再直接使用self,将不会造成循环引用的问题
        NSLog(@"%@", self);
        return nil;
    }];

    // 7.4元组宏，
    
    // RACTuplePack包装数据成元组
    RACTuple *tuple = RACTuplePack(@"zhangsan", @18, @1.78);
    NSLog(@"%@", tuple);
    
    // RACTupleUnpack解析元组数据友
    RACTupleUnpack(NSString *name, NSNumber *age, NSNumber *height) = tuple;
    NSLog(@"%@ %@ %@", name, age, height);
    
}

- (void)testBasicFunction {
    RACSignal *single = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送消息前");
        [subscriber sendNext:@"hello RAC"];
       return [RACDisposable disposableWithBlock:^{
           NSLog(@"发送消息后");
       }];
    }];
    
    [single subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}


@end
