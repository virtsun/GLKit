//
//  UIApplication+Present.m
//  Tool
//
//  Created by l.t.zero on 2018/8/27.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import "UIApplication+Present.h"

@implementation UIApplication(Present)

+ (UINavigationController *)navigationController{
    return [self currentViewController].navigationController;
}

+ (UIViewController*)currentViewController{
    UIViewController* viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return[self findBestViewController:viewController];
}

//递归方法

+ (UIViewController*)findBestViewController:(UIViewController*)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
        
    }else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        
        UISplitViewController* svc = (UISplitViewController*) vc;
        
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    }else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
        
    }else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
    }else{
        return vc;
    }
    
}

@end
