//
//  LiPURLProtocol.h
//  LiPWKWebview
//
//  Created by Sun Lantao on 2018/6/29.
//  Copyright © 2018年 Sun Lantao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (CYLNSURLProtocolExtension)
- (NSURLRequest *)cyl_getPostRequestIncludeBody;
@end

@interface CKURLProtocol : NSURLProtocol

@end
