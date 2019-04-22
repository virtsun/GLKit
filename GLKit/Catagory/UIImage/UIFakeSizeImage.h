//
//  UIFakeSizeImage.h
//  Moline
//
//  Created by sunlantao on 2019/4/19.
//  Copyright © 2019 sunlantao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFakeSizeImage : UIImage

@property (nonatomic, assign) CGSize fakeSize;

+ (instancetype)imageNamed:(NSString *)name preferedSize:(CGSize)size;

@end
