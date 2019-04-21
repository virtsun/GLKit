//
//  NSObject+Observer.m
//  GLKit
//
//  Created by sunlantao on 2019/4/11.
//  Copyright © 2019 sunlantao. All rights reserved.
//

#import "NSObject+Observer.h"
#import <objc/runtime.h>

@interface GLObserverHelper : NSObject

//@property (nonatomic, unsafe_unretained) id target;
@property (nonatomic, unsafe_unretained) id observer;
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, weak) GLObserverHelper *factor;

@property (nonatomic, copy) void (^block)(id value);

@end

@implementation GLObserverHelper

- (void)dealloc{
    if ( _factor ){
        [_observer removeObserver:self forKeyPath:_keyPath];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:self.keyPath]){
        if (self.block){
            self.block(change[NSKeyValueChangeNewKey]);
        }
    }
}

@end

@implementation NSObject(Observer)

- (void) gl_addObserver:(id)observer forKeyPath:(NSString *)keyPath block:(void (^)(id v))block{
    
    GLObserverHelper *helper = [[GLObserverHelper alloc] init];
    GLObserverHelper *sub = [[GLObserverHelper alloc] init];
//    sub.target = helper.target = self;
    sub.observer = helper.observer = observer;
    sub.keyPath = helper.keyPath = keyPath;
    sub.block = helper.block = block;
    
    [observer addObserver:helper forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];

    helper.factor = sub;
    const char *helperKey = [NSString stringWithFormat:@"%zd", [helper hash]].UTF8String;
    const char *subKey = [NSString stringWithFormat:@"%zd", [sub hash]].UTF8String;

    objc_setAssociatedObject(self, helperKey, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(observer, subKey, sub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
