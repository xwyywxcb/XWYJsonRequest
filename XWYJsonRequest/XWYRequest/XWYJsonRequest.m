//
//  XWYJsonRequest.m
//  XWYJsonRequest
//
//  Created by xwy on 15/8/24.
//  Copyright (c) 2015年 xiongwenyi. All rights reserved.
//
#import "XWYJsonRequest.h"
#import "XWYAPI.h"
#import "XWYResponse.h"
@implementation XWYJsonRequest
static XWYJsonRequest *instance = nil;
static dispatch_once_t onceToken;
+(XWYJsonRequest*) sharedJsonRequest {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(instance == nil) {
            instance = [[super allocWithZone:NULL]init];
        }
    });
    return instance;
}

+(void) execute:(NSString*) url params:(NSDictionary *)params  callback:(REQUEST_CALLBACK)callback {
    XWYJsonRequest* jr = [self sharedJsonRequest];
    return [jr _execute:url params:params callback:callback];
}

+(void) uploadImage:(UIImage *)image withUrl:(NSString *)url withParams:(NSDictionary *) params callback:(REQUEST_CALLBACK)callback {
    XWYJsonRequest* jr = [self sharedJsonRequest];
    return [jr _execute:url params:params image:image callback:callback];
}

- (void)_execute:(NSString*) url params:(NSDictionary *)params  callback:(REQUEST_CALLBACK)callback{
//    [SVProgressHUD showWithStatus:@"正在加载..."];
    [[XWYApi sharedClient] POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        XWYResponse *response = [[XWYResponse alloc]init];
        response.body = [responseObject objectForKey:@"data"];
        NSLog(@"%@ response.body=%@", url, responseObject);
        response.error = nil;
        if(callback != nil)
            callback(response);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        XWYResponse *response = [[XWYResponse alloc]init];
        response.header = nil;
        response.body = nil;
        response.messsage = nil;
        response.error = error;
        response.status = @"error";
        [self afterExecute:response];
        callback(response);
    }];
}

- (void)_execute:(NSString*) url params:(NSDictionary *)params image:(UIImage *)image callback:(REQUEST_CALLBACK)callback{
//    [SVProgressHUD showWithStatus:@"正在加载..."];
    [[XWYApi sharedClient] POST:url
                    parameters:params
     constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         UIImage *newImage;
         //设置image的尺寸
         CGSize imagesize = image.size;
         imagesize.width=1000.f;
         imagesize.height=1000.f*image.size.height/image.size.width;
         //对图片大小进行压缩--
         newImage = [self imageWithImage:image scaledToSize:imagesize];
         //图片上传
         NSData* data = UIImageJPEGRepresentation(newImage, 0.1);
         // 上传文件
         NSString *fileName = [NSString stringWithFormat:@"image.jpg"];
         [formData appendPartWithFileData:data name:@"upfile" fileName:fileName mimeType:@"image/jpeg"];
     }
                       success:^(NSURLSessionDataTask *task, id responseObject) {
                           XWYResponse *response = [[XWYResponse alloc]init];
                           NSLog(@"%@ response.body=%@", url, responseObject);
                           response.error = nil;
                           if(callback != nil)
                               callback(response);
                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                           XWYResponse *response = [[XWYResponse alloc]init];
                           response.header = nil;
                           response.body = nil;
                           response.messsage = nil;
                           response.error = error;
                           response.status = @"error";
                           [self afterExecute:response];
                           callback(response);
                       }];
}

//- (BOOL)beforeExecute:(AFHTTPRequestOperationManager*)manager {
//    NSOperationQueue *operationQueue = manager.operationQueue;
//    
//    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                [operationQueue setSuspended:NO];
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//            default:
//                [operationQueue setSuspended:YES];
//                break;
//        }
//    }];
//    [manager.reachabilityManager startMonitoring];
//    return true;
//}

- (BOOL) afterExecute:(XWYResponse *) response {
    
    if (response.error == nil) {
        return TRUE;
    }
    
    if ([response.error code] == NSURLErrorNotConnectedToInternet) {
        [self alertErrorMessage:@"网络不给力"];
        return FALSE;
    }
    
    NSLog(@"server error text is %@", response.text);
    [self alertErrorMessage:@"服务器故障，请稍后再试。"];
    
    return true;
}

-(void)alertErrorMessage:(NSString *)str
{
//    [SVProgressHUD showErrorWithStatus:str];
}

//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
