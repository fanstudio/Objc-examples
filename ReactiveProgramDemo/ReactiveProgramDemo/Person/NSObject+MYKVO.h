//
//  NSObject+MYKVO.h
//  ReactiveProgramDemo
//
//  Created by 张帆 on 16/7/11.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MYKVO)

- (void)my_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

- (void)my_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object value:(id)value;

@end
