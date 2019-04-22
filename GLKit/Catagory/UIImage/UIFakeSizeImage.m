//
//  UIFakeSizeImage.m
//  Moline
//
//  Created by sunlantao on 2019/4/19.
//  Copyright © 2019 sunlantao. All rights reserved.
//

#import "UIFakeSizeImage.h"

@implementation UIFakeSizeImage

+ (instancetype)imageNamed:(NSString *)name preferedSize:(CGSize)size{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ui" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    NSInteger ratio = [UIScreen mainScreen].scale;
    UIFakeSizeImage *image = nil;
    do{
        NSString *filename = ratio > 1?[name stringByAppendingFormat:@"@%ldx", (long)ratio]:name;
        NSString *file = [bundle pathForResource:filename ofType:@"png"];
        
        if (!file) continue;
        
        image = [[self alloc] initWithContentsOfFile:file];
        if (image) break;
    }while ((--ratio) >= 0);

    image.fakeSize = size;
    
    return image;
}

- (CGSize)size{
    if (CGSizeEqualToSize(self.fakeSize, CGSizeZero)){
        return [super size];
    }else{
        return self.fakeSize;
    }
}

@end
