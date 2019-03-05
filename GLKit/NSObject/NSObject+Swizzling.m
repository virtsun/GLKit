//
//  NSObject+Swizzling.m
//  RuntimeDemo
//
//  Created by huangyibiao on 16/1/12.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
/*
void dynamicMethodIMP(id self, SEL _cmd) {
  NSLog(@"%@(->%@)", [self class], NSStringFromSelector(_cmd));
}*/


@implementation NSObject(Swizzling)

+ (NSString *)className {
    return NSStringFromClass(self);
}

//#if !defined(DEBUG)

+ (void)load{
    
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
      Method originMethod = class_getInstanceMethod([self class], @selector(methodSignatureForSelector:));
      Method replaceMethod = class_getInstanceMethod([self class], @selector(rp_methodSignatureForSelector:));

      method_exchangeImplementations(originMethod, replaceMethod);

      originMethod = class_getInstanceMethod([self class], @selector(forwardInvocation:));
      replaceMethod = class_getInstanceMethod([self class], @selector(rp_forwardInvocation:));

      method_exchangeImplementations(originMethod, replaceMethod);

  });
}

//#endif

// 全面
+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector {
  Class class = [self class];

  Method originalMethod = class_getInstanceMethod(class, originalSelector);
  Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
  
  // 若已经存在，则添加会失败
  BOOL didAddMethod = class_addMethod(class,
                                      originalSelector,
                                      method_getImplementation(swizzledMethod),
                                      method_getTypeEncoding(swizzledMethod));
  
  // 若原来的方法并不存在，则添加即可
  if (didAddMethod) {
    class_replaceMethod(class,
                        swizzledSelector,
                        method_getImplementation(originalMethod),
                        method_getTypeEncoding(originalMethod));
  } else {
    method_exchangeImplementations(originalMethod, swizzledMethod);
  }
}


//+ (BOOL)rp_resolveClassMethod:(SEL)sel{
//    return [self rp_resolveClassMethod:sel];
//}
//+ (BOOL)rp_resolveInstanceMethod:(SEL)sel{
//    NSLog(@"%@(->%@)", [self class], NSStringFromSelector(sel));
//
//    if(class_getInstanceMethod(self, sel) == NULL){
//        return class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
//    }
//
//    return [self rp_resolveInstanceMethod:sel];
//}

//unrecognized selector sent to instance
- (void)ignore{
  /*找不到的selector用ignore代替，此处不做任何处理*/
}
- (NSMethodSignature *)rp_methodSignatureForSelector:(SEL)aSelector {

  NSMethodSignature *ms = [self rp_methodSignatureForSelector:aSelector];

  if (ms == nil) {
    NSString *strClass = NSStringFromClass([self class]);
    if (![[strClass substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"UI"])
      ms = [[self class] instanceMethodSignatureForSelector:@selector(ignore)];

  }
  return ms;
}

- (void)rp_forwardInvocation:(NSInvocation *)anInvocation {

  @try {
    [self rp_forwardInvocation:anInvocation];
  } @catch (NSException *exception) {
    NSLog(@"%s-%@", __PRETTY_FUNCTION__, exception.reason);
  } @finally {

  }

}

@end
