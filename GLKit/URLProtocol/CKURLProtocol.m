//
//  LiPURLProtocol.m
//  LiPWKWebview
//
//  Created by Li Peng on 2018/6/29.
//  Copyright © 2018年 Li Peng. All rights reserved.
//

#import "CKURLProtocol.h"
#import <UIKit/UIKit.h>
#import "CKCache.h"

static NSString *URLProtocolHandledKey = @"URLHasHandle";


@implementation NSURLRequest (CYLNSURLProtocolExtension)

- (NSURLRequest *)cyl_getPostRequestIncludeBody {
    return [[self cyl_getMutablePostRequestIncludeBody] copy];
}

- (NSMutableURLRequest *)cyl_getMutablePostRequestIncludeBody {
    NSMutableURLRequest * req = [self mutableCopy];
    if ([self.HTTPMethod isEqualToString:@"POST"]) {
        if (!self.HTTPBody) {
            NSInteger maxLength = 1024;
            uint8_t d[maxLength];
            NSInputStream *stream = self.HTTPBodyStream;
            NSMutableData *data = [[NSMutableData alloc] init];
            [stream open];
            BOOL endOfStreamReached = NO;
            //不能用 [stream hasBytesAvailable]) 判断，处理图片文件的时候这里的[stream hasBytesAvailable]会始终返回YES，导致在while里面死循环。
            while (!endOfStreamReached) {
                NSInteger bytesRead = [stream read:d maxLength:maxLength];
                if (bytesRead == 0) { //文件读取到最后
                    endOfStreamReached = YES;
                } else if (bytesRead == -1) { //文件读取错误
                    endOfStreamReached = YES;
                } else if (stream.streamError == nil) {
                    [data appendBytes:(void *)d length:bytesRead];
                }
            }
            req.HTTPBody = [data copy];
            [stream close];
        }
        
    }
    return req;
}
@end

@interface CKURLProtocol()<NSURLSessionDelegate,NSURLSessionDataDelegate>

@property (nonatomic,strong) NSURLSession *session;
@property (strong, nonatomic) NSMutableData *responseData;
@property (nonatomic) BOOL beginAppendData;

@end

@implementation CKURLProtocol

#pragma mark 初始化请求

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    
    //只处理http和https请求
    NSString *scheme = [[request URL] scheme];
    if ( (([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
           [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame)))
    {
        //看看是否已经处理过了，防止无限循环
        if ([NSURLProtocol propertyForKey:URLProtocolHandledKey inRequest:request]) {
            return NO;
        }
        return YES;
    }
    return NO;
}

+ (NSURLRequest *) canonicalRequestForRequest:(NSURLRequest *)request {
    return [request cyl_getPostRequestIncludeBody];
}

#pragma mark 通信协议内容实现

- (void)startLoading
{
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    [NSURLProtocol setProperty:@YES forKey:URLProtocolHandledKey inRequest:mutableReqeust];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    [[self.session dataTaskWithRequest:mutableReqeust] resume];
    
}

- (void)stopLoading
{
    [self.session invalidateAndCancel];
}

#pragma mark - dataDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)newRequest completionHandler:(void (^)(NSURLRequest *))completionHandler
{
    NSMutableURLRequest *    redirectRequest;
    
    redirectRequest = [newRequest mutableCopy];
    [[self class] removePropertyForKey:URLProtocolHandledKey inRequest:redirectRequest];
    
    [[self client] URLProtocol:self wasRedirectedToRequest:redirectRequest redirectResponse:response];
    
    [self.session invalidateAndCancel];
    [[self client] URLProtocol:self didFailWithError:[NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:nil]];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    NSInteger expected = response.expectedContentLength > 0 ? (NSInteger)response.expectedContentLength : 0;
    self.responseData = [[NSMutableData alloc] initWithCapacity:expected];
    if (completionHandler) {
        completionHandler(NSURLSessionResponseAllow);
    }
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    if ([dataTask.currentRequest.URL.absoluteString hasSuffix:@"webp"]) {
        self.beginAppendData = YES;
        [self.responseData appendData:data];
    }
    if (!_beginAppendData) {
        [self.client URLProtocol:self didLoadData:data];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    if (error) {
        [self.client URLProtocol:self didFailWithError:error];
    }else{
        if ([task.currentRequest.URL.absoluteString hasSuffix:@"webp"]) {
            NSLog(@"webp---%@",task.currentRequest.URL);
            
            UIImage *imgData = [UIImage imageWithData:self.responseData];
            NSData *transData = UIImageJPEGRepresentation(imgData, 0.8f);
            self.beginAppendData = NO;
            self.responseData = nil;
            [self.client URLProtocol:self didLoadData:transData];
        }
        [self.client URLProtocolDidFinishLoading:self];
    }
    
}

@end
