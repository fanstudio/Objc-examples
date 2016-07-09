//
//  FZServer.m
//  cocoaAsyncSocket
//
//  Created by 张帆 on 16/6/26.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import "FZServer.h"
#import "GCDAsyncSocket.h"

@interface FZServer() <GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *socket;
@property (nonatomic, strong) NSMutableArray <GCDAsyncSocket *> *clientSockets;

@end

@implementation FZServer

- (void)start {
    // 创建socket
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self
                                             delegateQueue:dispatch_get_global_queue(0, 0)];
    // accpet
    NSError *error;
    [self.socket acceptOnPort:10086 error:&error];
    if (error) {
        NSLog(@"accept failed, %@", error);
        return;
    } else {
        NSLog(@"ok,start...");
    }
    
    // 初始化客户地址池
    self.clientSockets = [NSMutableArray array];
}


- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    // 发送提示数据
    [newSocket writeData:[self noticeData] withTimeout:-1 tag:0];
    
    // 接收客户端的数据，并添加
    [newSocket readDataWithTimeout:-1 tag:0];
    [self.clientSockets addObject:newSocket];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    // 将发送过来的数据解析成字符串
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // 判断是否为退出操作
    if ([string hasPrefix:@"exit"]) {
        [self.clientSockets removeObject:sock];
        return;
    }
    
    // 回显发送过来的数据
    NSString *retString = [NSString stringWithFormat:@"%@\n[fanstudio:~]", string];
    [sock writeData:[retString dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    
    
    [sock readDataWithTimeout:-1 tag:0];
}

- (NSData *)noticeData {
    NSString *str = @"~~~~~welcome to fanstudio~~~~~\n[fanstudio:~]";
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

@end
