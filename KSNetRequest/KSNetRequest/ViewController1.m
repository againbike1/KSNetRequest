//
//  ViewController1.m
//  KSNetRequest
//
//  Created by kong on 15/11/30.
//  Copyright © 2015年 孔. All rights reserved.
//

#import "ViewController1.h"
#import "KSNetRequest.h"
#import "KSCache.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)startRequest:(id)sender {
    
    [KSNetRequest requestTarget:self POST:@"http://api-1.xianhenet.com/hunparapp2/sysNew/getSysNewList" parameters:@{@"deviceType":@(0)} success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:nil];
    
}
- (void)reloadRequest
{
    [self startRequest:nil];
}

- (IBAction)cleanCache:(id)sender {
    
    //清缓存
    if ([KSCache cleanCache]){
        UIAlertController* al = [UIAlertController alertControllerWithTitle:@"清空成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:al animated:YES completion:^{
            [al dismissViewControllerAnimated:YES completion:NULL];
        }];
    }
}

@end
