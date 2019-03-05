//
//  UIApplication+Present.h
//  Tool
//
//  Created by l.t.zero on 2018/8/27.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication(Present)

+ (UINavigationController *)navigationController;
+ (UIViewController*)currentViewController;

@end
