//
//  LFTCache.h
//  Leaflet
//
//  Created by l.t.zero on 2018/9/13.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface CKCache : NSObject

CLASS_SINGLETON_DECLARE(cache)

- (void)cache:(id)data forKey:(NSString *)key;

- (id)cacheForKey:(NSString *)key;
- (BOOL)removeCacheForKey:(NSString *)key;

@end
