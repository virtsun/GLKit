//
//  KeyChainStore.h
//  OneCardMall
//
//  Created by 李策 on 2018/9/3.
//  Copyright © 2018年 李策. All rights reserved.
//  系统钥匙串KeyChain

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end
