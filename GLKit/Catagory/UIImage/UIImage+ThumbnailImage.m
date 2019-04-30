//
//  UIImage+ThumbnailImage.m
//  lib51PK_IOS
//
//  Created by L.T.ZERO on 14-4-2.
//  Copyright (c) 2014年 iava. All rights reserved.
//

#import "UIImage+ThumbnailImage.h"

@implementation UIImage(ThumbnailImage)

- (UIImage *)thumbnailWithSize:(CGSize)size{

    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
    
}

- (UIImage *)thumbnailWithImageWithoutScale:(CGSize)size{

    CGFloat scale = 1.f;
    CGSize scaleSize = CGSizeMake(size.width * scale, size.height * scale);

    CGSize oldSize = self.size;
    CGRect rect;

    if (scaleSize.width/scaleSize.height > oldSize.width/ oldSize.height) {

        rect.size.width = scaleSize.height* oldSize.width/ oldSize.height;
        rect.size.height = scaleSize.height;
        rect.origin.x = (scaleSize.width - rect.size.width)/2;
        rect.origin.y = 0;

    }else{

        rect.size.width = scaleSize.width;
        rect.size.height = scaleSize.width* oldSize.height/ oldSize.width;
        rect.origin.x = 0;
        rect.origin.y = (scaleSize.height - rect.size.height)/2;
    }

    UIGraphicsBeginImageContext(scaleSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    UIRectFill(CGRectMake(0, 0, scaleSize.width, scaleSize.height));//clear background

    [self drawInRect:rect];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;
    
}

- (void)writeToFile:(NSString *)path atomically:(BOOL)atomically{
    NSData *data = UIImageJPEGRepresentation(self, 1.f);
    [data writeToFile:path atomically:atomically];
}

+ (UIImage *)captureWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [UIScreen mainScreen].scale);
    // IOS7及其后续版本
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    } else { // IOS7之前的版本
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

@end
