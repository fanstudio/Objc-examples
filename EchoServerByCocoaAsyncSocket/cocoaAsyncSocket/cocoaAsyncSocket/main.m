//
//  main.m
//  cocoaAsyncSocket
//
//  Created by 张帆 on 16/6/26.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZServer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FZServer *server = [FZServer new];
        [server start];
        
        [[NSRunLoop mainRunLoop] run];
    }
    return 0;
}
