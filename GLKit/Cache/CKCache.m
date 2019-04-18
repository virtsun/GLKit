//
//  LFTCache.m
//  Leaflet
//
//  Created by l.t.zero on 2018/9/13.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import "CKCache.h"
#include <CommonCrypto/CommonDigest.h>
#import "SerializeKit.h"

static __inline  NSString *md5(NSString *str){
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

@implementation CKCache

CLASS_SINGLETON_SYNTHESIZE(cache)

- (id)init{
    
    if (self = [super init]){
        if (![[NSFileManager defaultManager] fileExistsAtPath:[self path]]){
            [[NSFileManager defaultManager] createDirectoryAtPath:[self path] withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    
    return self;
}

- (NSString *)path{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [document stringByAppendingPathComponent:@"cache"];
}

- (void)cache:(id)obj forKey:(NSString *)key{
    if (!obj || ![key isKindOfClass:[NSString class]]) return;
    
    NSString *cacheKey = md5(key);
    
    NSString *path = [[self path] stringByAppendingPathComponent:cacheKey];
    SERIALIZE_ARCHIVE(obj, cacheKey, path);
}

-(id)cacheForKey:(NSString *)key{
    if (![key isKindOfClass:[NSString class]]) return nil;
    
    NSString *cacheKey = md5(key);
    NSString *path = [[self path] stringByAppendingPathComponent:cacheKey];

    id obj;
    SERIALIZE_UNARCHIVE(obj, cacheKey, path);
    
    return obj;
}
- (BOOL)removeCacheForKey:(NSString *)key{
    if (![key isKindOfClass:[NSString class]]) return NO;
    
    NSString *cacheKey = md5(key);
    NSString *path = [[self path] stringByAppendingPathComponent:cacheKey];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]){
        return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    return YES;
}

@end
