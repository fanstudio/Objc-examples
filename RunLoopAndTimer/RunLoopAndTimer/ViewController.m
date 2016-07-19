//
//  ViewController.m
//  RunLoopAndTimer
//
//  Created by zhangfan on 16/5/27.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) NSThread *otherThread;
@end

@implementation ViewController

#pragma mark - 写在前面

/*
 参考：http://blog.ibireme.com/2015/05/18/runloop/
 
 1.RunLoop概述
 在程序框架设计中，通常将一个线程设计成一次只执行一个任务，这样来降低程序的复杂度。
 个人的编程经历中，接触过开源路由框架zebra也是这样设计的。在Foundation框架中也
 有类似的这样的设计。
 
 RunLoop,从字面意思上讲它是一个运行循环，它将所有的需要执行的代码抽象成不同的调
 度单元来执行,IOS中RunLoop对应的对象就是NSRunLoop。
 
 2.NSRunLoop创建方式
 NSRunLoop的创建和获取都是通过类方法currentLoop来执行。注意一个线程只会存在一
 个RunLoop，（别问我为什么，现有资料都这么说，我没太深入。）
 
 3.NSRunLoop的运行与模式
 RunLoop在运行的设计上拆成了多个模式,在运行时需要执行相应的模式，如果调用的是run
 它是默认模式。（至于为什么这样设计，太深入，不清楚）
 
 4.NSRunLoop调度执行单元
 RunLoop的具体调用单元，抽象成了以下几种，需要注意的是，RunLoop必须有一个Timer
 或者Source,否则会退出。
 
 5.NSRunLoop调度过程
 XXX
 需要注意的是，NSRunLoop至少有一个timer或source，否则会退出。
 

 6.拓展
 想深入了解一下coreFoundation中的RunLoop
 
 

 
 
 深入一下
 */

#pragma mark - 1.runLoop简单应用
/*
 示例：
 主线程中开启一个子线程，子线程运行RUNLOOP
 通过按钮点击事件，在主线程中给子线程上添加一个任务
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.otherThread = [[NSThread alloc] initWithTarget:self
                                                selector:@selector(otherTaskThread)
                                                  object:nil];
    [self.otherThread start];
}

- (IBAction)addTasckForAnotherThread:(id)sender {
    [self performSelector:@selector(needOtherThreadDoSomething) onThread:self.otherThread withObject:nil waitUntilDone:YES];
}

- (void)otherTaskThread {
    /***/
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [runLoop run];
    
    NSLog(@"runLoop exit");
    [NSThread exit];
}

- (void)needOtherThreadDoSomething {
    NSLog(@"这是需要子线程做的事情");
}


#pragma mark - 2.定时器NSTimer与RunLoop

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //    [self addTimer];
    //    [self addScheduledTimer];
    //    [self addOtherThreadTimer];
    //    [self addGCDTimer];
    //    [self listenRunLoopActivty];
}


- (void)onTimer {
    NSLog(@"%@ %@", NSRunLoop.currentRunLoop.currentMode, [NSThread currentThread]);
}

#pragma mark 2.1定时器使用方法一

- (void)addTimer {
    /*
     1.Runloop是指一个运行循环，用于响应处理各类？？
     2.每个线程中只能有一个RUNLOOP??
     3.RunLoop 下存在五个模式(这个模式有点类似于状态机这种东东，但能用到的只有两个模式)，
     每次只运行在一种模式下。每个模式下至少有一个source或者timer，否则RUNLOOP开启后会自动退出？
     4.RUNLOOP的创建方式与使用
     5.与RUNLOOP相关的类
     6.NSTimer是会受runLoop影响的。
     */
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];

    /*    
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
     下面这行等效于timer同时添加到forMode:NSDefaultRunLoopMode和forMode:UITrackingRunLoopMode
     也就是相当于同时执行了上面两行代码，这样可以保证界面上的UIScrollView滚动，或类似操作Timer都会运行
     （个人理解只是运行，而不是精确按时间来执行！！！）
     */
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

#pragma mark 2.2定时器使用方法二

- (void)addScheduledTimer {
    /* 
        使用下面这种方式创建的定时器会自动将定时器添加到当前线程的runloop
        (如果是子线程，则添加到子线程的runloop)并且设置为默认模式
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self
                            selector:@selector(onTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        所以这种方式的创建，一旦界面有scrollView滚动等操作，定时器将不能工作，需等到runloop恢复到默认模式

     */
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
                                                selector:@selector(onTimer) userInfo:nil repeats:YES];
}

#pragma mark 2.3注意定时器在子线程中的使用方法

- (void)addOtherThreadTimer {
    [NSThread detachNewThreadSelector:@selector(runLoopInotherThreadTimer) toTarget:self withObject:nil];
}

- (void)runLoopInotherThreadTimer {
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [self addScheduledTimer];
    [runloop run];
}


#pragma mark - 3.不受runLoop影响的定时器

- (void)addGCDTimer {
    /* 
     1.利用dispatch_source_create创建定时器，输入“dispath_srouce timer”自动提示
     参数1：表示通过dispatch_source_create创建的是一个定时器
     参数2：描述说明，线程ID
     参数3：更详细的描述信息
     参数4：指定创建的对象运行的队列
    */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    
    /*
     2.配置定时器
     参数1：配置的对象
     参数2：定时器从什么时候开始计时，DISPATCH_TIME_NOW 从表现计时
     参数3：定时器的间隔时间 2.0 * NSEC_PER_SEC （2秒）
     参数4：允许的误差值，填0表示不允许误差
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    /*
     3.设置定时器到点执行的内容
     */
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"%@ %@", [NSRunLoop currentRunLoop].currentMode, [NSThread currentThread]);
    });
    
    // 4.启用定时器
    dispatch_resume(timer);
    
    self.timer = timer;
    
}

#pragma mark - 4.定时器CADisplayLink
#pragma mark 还未实现


#pragma mark - 5.深入了解RunLoop

#pragma mark 5.1XXX与NSRunLoop的对应关系


#pragma mark - 6.XXX的一些接口

#pragma mark - 6.1CFRunloopSource简单介绍

- (void)doOnTouch {
    /*
     通过断点跟踪，可以发现该方法在RunLoop中其实是一个???事件。
     */
    NSLog(@"enter");
}

#pragma mark - 6.2CFRunLoopObserverRef简单介绍

- (void)listenRunLoopActivty {
    
    /*
     CFRunLoopObserverRef用于监听runloop状态的改变
         typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
         kCFRunLoopEntry = (1UL << 0),
         kCFRunLoopBeforeTimers = (1UL << 1),
         kCFRunLoopBeforeSources = (1UL << 2),
         kCFRunLoopBeforeWaiting = (1UL << 5),
         kCFRunLoopAfterWaiting = (1UL << 6),
         kCFRunLoopExit = (1UL << 7),
         kCFRunLoopAllActivities = 0x0FFFFFFFU
         };
        各状态的说明在下面的代码中体现
    */
    
    /*
     示例：监听当前RUNLOOP状态的改变
     
     1.创建一个observer
     
     参数1：怎么分配存储空间
     参数2：需要监听的状态，这里填监听所有状态
     参数3：是否持续监听
     参数4：优先级，填0（我也不清楚）
     参数5：相应的状态发生改变时的回调
     */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"即将进入RUNLOOP");
                break;
                
            case kCFRunLoopBeforeTimers:
                NSLog(@"将要处理timer事件");
                break;
                
            case kCFRunLoopBeforeSources:
                NSLog(@"将要处理source事件");
                break;
            
            case kCFRunLoopBeforeWaiting:
                NSLog(@"即将休眠");
                break;
                
            case kCFRunLoopAfterWaiting:
                NSLog(@"被唤醒");
                break;
                
            case kCFRunLoopExit:
                NSLog(@"退出");
                break;
                
            default:
                break;
        }
    });
    
    /*
     2.添加观察者到RUNLOOP，并指定模式
        NSRunLoopCommonModes <----> kCFRunLoopCommonModes
        NSDefaultRunLoopMode <----> kCFRunLoopDefaultMode
     */
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    
    /*
     3.其它补充
     CFRunLoop其实除了上面的方法还有下面的方法
      - CFRunLoopAddSource(, , )
      - CFRunLoopAddTimer(, , ) 等价于[NSRunLoop currentRunLoop] addTimer: forMode:
      - 需要注意的是 [NSRunLoop currentRunLoop] addObserver: forKeyPath: options: context:
       并不等价于CFRunLoopAddObserver

    */

    
}





@end
