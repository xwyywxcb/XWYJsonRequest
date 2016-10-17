//
//  XWYAPI.h
//  XWYJsonRequest
//
//  Created by xwy on 15/7/20.
//  Copyright (c) 2015年 com.xiongwenyi. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface XWYApi : AFHTTPSessionManager

+ (XWYApi*)sharedClient;

@end
