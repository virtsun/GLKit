//
//  GCDTimerQueue.h
//  Whirlwind
//
//  Created by sunlantao on 2018/11/15.
//  Copyright © 2018年 sunlantao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDTimer.h"

@protocol GCDTimerQueue <NSObject>

- (void)timerTiktok:(id<GCDTimerQueue>)obj;

@end

@interface GCDTimerQueue : NSObject


+ (instancetype)defaultQueue;

- (void)configTimerWithInterval:(uint64_t)millisecond
                      queue:(dispatch_queue_t)queue;
/**
 *interval:单位为sec
 **/
+ (instancetype)timerQueueWithInterval:(uint64_t)millisecond
                                 queue:(dispatch_queue_t)queue;

- (void)push:(id<GCDTimerQueue>)object;
- (void)pop:(id<GCDTimerQueue>)object;

@end
