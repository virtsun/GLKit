//
//  NSDate+Extends.h
//  Moline
//
//  Created by l.t.zero on 2019/4/20.
//  Copyright © 2019 sunlantao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(Extends)

+ (NSInteger)ageFromDate:(NSDate *)date;
- (NSString *)astro;
+ (NSString *)astroFromDateString:(NSString *)dateString;

@end
