//
//  XWYResponse.h
//  XWYJsonRequest
//
//  Created by xwy on 15/8/24.
//  Copyright (c) 2015年 xiongwenyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWYResponse : NSObject
@property(strong, nonatomic) NSDictionary *header;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *messsage;
@property(strong, nonatomic) NSDictionary *body;
@property(strong, nonatomic) NSString *text;
@property(strong, nonatomic) NSError *error;
@end
