//
//  ViewController2.m
//  KSNetRequest
//
//  Created by kong on 15/11/30.
//  Copyright © 2015年 孔. All rights reserved.
//

#import "ViewController2.h"
#import "KSNetRequest.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)reloadRequest
{
    [KSNetRequest requestTarget:self POST:@"http://api-1.xianhenet.com/hunparapp2/sysNew/getSysNewList" parameters:@{@"deviceType":@(0)} success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:nil];
}


@end
