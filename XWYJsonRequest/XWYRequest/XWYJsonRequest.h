//
//  XWYJsonRequest.h
//  XWYJsonRequest
//
//  Created by xwy on 15/8/24.
//  Copyright (c) 2015年 xiongwenyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class XWYResponse;
//接口数据返回类型
#define REQUEST_CALLBACK void (^)(XWYResponse *response)
@interface XWYJsonRequest : NSObject
/**
 *  POST请求接口
 *
 *  @param url      接口地址
 *  @param params   参数
 *  @param callback 回调Block
 */
+(void) execute:(NSString*) url params:(NSDictionary *)params  callback:(REQUEST_CALLBACK)callback;
/**
 *  上传图片 方法
 *
 *  @param url      上传图片地址
 *  @param params   参数
 *  @param image    要上传的图片
 *  @param callback 回调Block
 
    demo ：
 
 
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:[GlobalTools readToken] forKey:@"token"];
    [mutableDic setObject:@"40" forKey:@"userid"];
    [mutableDic setObject:@"1" forKey:@"activityid"];
 
    [XWYJsonRequest uploadImage:image
        withParams:mutableDic
    callback:^(LResponse *response) {
    }];
 
 
 */
+(void) uploadImage:(UIImage *)image withUrl:(NSString *)url withParams:(NSDictionary *) params callback:(REQUEST_CALLBACK)callback;
@end
