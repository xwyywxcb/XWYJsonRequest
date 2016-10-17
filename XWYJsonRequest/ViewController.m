//
//  ViewController.m
//  XWYJsonRequest
//
//  Created by air on 2016/10/17.
//  Copyright © 2016年 xwy. All rights reserved.
//

#import "ViewController.h"
#import "XWYJsonRequest.h"
#import "XWYResponse.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //POST/GET 获取数据
    NSDictionary *dic = @{@"ip":@"63.223.108.42"};
    __weak ViewController *_weakSelf = self;
    [XWYJsonRequest execute:@"getIpInfo.php" params:dic callback:^(XWYResponse *response) {
        _weakSelf.resultText.text = [self jsonToString:response.body];
    }];
    
    //带参数的图片上传,这里可以自己添加图片以及地址测试
//    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
//    [mutableDic setObject:@"token" forKey:@"token"];
//    [mutableDic setObject:@"1" forKey:@"id"];
//    UIImage *image = [UIImage imageNamed:@"upload.png"];
//    
//    [XWYJsonRequest uploadImage:image
//                        withUrl:@"url"
//                     withParams:mutableDic
//                       callback:^(XWYResponse *response) {
//                           
//                       }];
}

/**
 *  json转字符串
 */
- (NSString *)jsonToString:(NSDictionary *)dic
{
    if(!dic){
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
