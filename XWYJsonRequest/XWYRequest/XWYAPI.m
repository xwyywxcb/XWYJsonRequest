//
//  XWYAPI.h
//  XWYJsonRequest
//
//  Created by xwy on 15/7/20.
//  Copyright (c) 2015年 com.xiongwenyi. All rights reserved.
//

#import "XWYApi.h"
#import "AFNetworking.h"
/*-----------------URL----------------*/
#define APIBaseURLString          @"http://ip.taobao.com/service/"

@implementation XWYApi
+ (XWYApi *)sharedClient {
    static XWYApi *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        //设置我们的缓存大小 其中内存缓存大小设置10M  磁盘缓存50M
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:path];
        
        [config setURLCache:cache];
        
        _sharedClient = [[XWYApi alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
        
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                                   @"application/json",
                                                                   @"text/json",
                                                                   @"text/javascript",
                                                                   @"text/html",
                                                                   @"text/plain", nil];
    });
    
    return _sharedClient;
}
@end
