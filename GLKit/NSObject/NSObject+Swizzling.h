//
//  NSObject+Swizzling.h
//  RuntimeDemo
//
//  Created by huangyibiao on 16/1/12.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>   

@interface NSObject(Swizzling)

- (void)ignore;//unrecognized selector sent to instance
+ (NSString *)className;

+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;

@end


