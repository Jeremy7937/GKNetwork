//
//  ViewController.m
//  HttpsDemo
//
//  Created by 郭凯 on 16/4/19.
//  Copyright © 2016年 郭凯. All rights reserved.
//

#import "ViewController.h"
#import "GKNetwork.h"

#define kHttpsUrl @"https://test.api.hz-health.com.cn:451/api/Login/LoginValidate?strAccount=xhtest01&strPassword=123456"

#define kHttpUrl @"http://10.50.50.14:90/api/Login/LoginValidate?strAccount=xhtest01&strPassword=123456"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[GKNetwork sharedInstance] requestUrl:kHttpsUrl param:nil isGetMethod:YES completionBlockSuccess:^(id responseObject) {
        NSLog(@"success:%@", responseObject);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
