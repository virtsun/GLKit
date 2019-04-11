//
//  NSObject+Observer.h
//  GLKit
//
//  Created by sunlantao on 2019/4/11.
//  Copyright © 2019 sunlantao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define gl_keypath(OBJ, PATH) \
(((void)(NO && ((void)OBJ.PATH, NO)), # PATH))

#define GLObserver(obj, keyPath, blk) [self gl_addObserver:obj forKeyPath:@gl_keypath(obj, keyPath) block:blk];

@interface NSObject(Observer)

- (void) gl_addObserver:(id)observer forKeyPath:(NSString *)keyPath block:(void (^)(id newValue))block;

@end
