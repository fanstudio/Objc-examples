//
//  ViewController.m
//  ReactiveProgramDemo
//
//  Created by 张帆 on 16/7/11.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+MYKVO.h"


@interface ViewController ()

@property (nonatomic, strong) Person *p;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 本节通过自定义模仿实现KVO，来实现响应式编程
    
    self.p = [Person new];
    [self addMyKVO];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.p.age++;
}

#pragma mark - 系统自带的KVO

- (void)addSystemKVO {
    // 执行下面的代码后的细节
    // 1.动态创建NSKVONotifying_Person,NSKVONotifying_Person是Person子类,做KVO
    // 2.修改当前对象的isa指针->NSKVONotifying_Person
    // 3.只要调用对象的set,就会调用NSKVONotifying_Person的set方法
    // 4.重写NSKVONotifying_Person的set方法,1.[super set:] 2.通知观察者,告诉你属性改变
    
    [self.p addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc {
    [self.p removeObserver:self forKeyPath:@"age"];
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context {
    NSLog(@"keyPath:%@ object:%@ change:%@ context:%@", keyPath, object, change, context);
}

#pragma mark - 简单自定义实现KVO，不完整

- (void)addMyKVO {
    [self.p my_addObserver:self forKeyPath:@"age"];
}

- (void)my_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object value:(id)value {
    NSLog(@"keypath:%@ object:%@ value:%@", keyPath, object, value);
}


@end
