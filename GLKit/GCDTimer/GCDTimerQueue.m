//
//  GCDTimerQueue.m
//  Whirlwind
//
//  Created by sunlantao on 2018/11/15.
//  Copyright © 2018年 sunlantao. All rights reserved.
//

#import "GCDTimerQueue.h"
#import <UIKit/UIKit.h>

@interface GCDTimerQueue()

@property (nonatomic, strong) GCDTimer *timer;

@end

@implementation GCDTimerQueue{
    dispatch_queue_t __perform_queue_;
    NSHashTable *__hashTable_;
    NSRecursiveLock *__locker_;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithInterval:(uint64_t)millisecond
                                 queue:(dispatch_queue_t)queue{
    if (self = [super init]){
        [self configTimerWithInterval:millisecond queue:queue];
    }
    return self;
}

+ (instancetype)defaultQueue{
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (void)configTimerWithInterval:(uint64_t)millisecond
                      queue:(dispatch_queue_t)queue{
    if (_timer) return;
    
    __perform_queue_ = queue;
    __hashTable_ = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
    __locker_ = [[NSRecursiveLock alloc] init];
    
    __perform_queue_ = queue;
    
    __weak typeof(self) self_weak_ = self;
    _timer = [GCDTimer timerWithInterval:millisecond/1000.f block:^{
        [self_weak_ tiktok];
    } queue:dispatch_queue_create("Clawsofhades(Timer)", DISPATCH_QUEUE_SERIAL)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disposeNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disposeNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
}
+ (instancetype)timerQueueWithInterval:(uint64_t)millisecond
                                 queue:(dispatch_queue_t)queue{
    return [[self alloc] initWithInterval:millisecond queue:queue];
}
- (void)push:(id<GCDTimerQueue>)object{
  
    [__locker_ lock];
    if (![__hashTable_ containsObject:object]){
        [__hashTable_ addObject:object];
    }
    [__locker_ unlock];
    
    
    if (__hashTable_.count > 0 && _timer.suspend){
        [_timer start];
    }
}
- (void)pop:(id<GCDTimerQueue>)object{
    [__locker_ lock];
    if ([__hashTable_ containsObject:object]){
        [__hashTable_ removeObject:object];
    }
    [__locker_ unlock];
}

#pragma mark --
#pragma mark -- foreground & background
- (void)disposeNotification:(NSNotification *)notification{
    if ([notification.name isEqualToString:UIApplicationDidEnterBackgroundNotification]){
        [_timer stop];
    }else if ([notification.name isEqualToString:UIApplicationWillEnterForegroundNotification]){
        if (__hashTable_.count > 0 && _timer.suspend){
            [_timer start];
        }
    }
}

#pragma mark --
#pragma mark -- TikTok

- (void)tiktok{
    
    [__locker_ lock];
    if (self->__hashTable_.allObjects.count == 0){
        [self->_timer stop];
        [__locker_ unlock];

        return;
    }
    
    for (id<GCDTimerQueue> obj in [self->__hashTable_ objectEnumerator]){
        if ([obj respondsToSelector:@selector(timerTiktok:)]){
            
            if (strcmp(dispatch_queue_get_label(__perform_queue_), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
                CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopCommonModes, ^{
                    [obj timerTiktok:obj];
                });
            } else {
                dispatch_async(__perform_queue_, ^{
                    [obj timerTiktok:obj];
                });
            }
           
        }
    }
    [__locker_ unlock];
}

@end
