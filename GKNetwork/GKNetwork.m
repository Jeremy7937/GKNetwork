//
//  GKNetwork.m
//  HttpsDemo
//
//  Created by 郭凯 on 16/4/19.
//  Copyright © 2016年 郭凯. All rights reserved.
//

#import "GKNetwork.h"

@implementation GKNetwork
{
    AFURLSessionManager *_manager;
}

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    
    return self;
}

- (void)requestUrl:(NSString *)url param:(NSDictionary *)param isGetMethod:(BOOL)isGet completionBlockSuccess:(void (^)(id ))success failure:(void (^)(NSError *))failure {
    
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [NSURLConnection connectionWithRequest:request delegate:self];
    if (isGet) {
        request.HTTPMethod = @"GET";
    }else {
        request.HTTPMethod = @"POST";
    }
    
    //配置用户名 密码
    NSString * str = [NSString stringWithFormat:@"%@:%@",@"HZ_API",@"123456"];
    //  进行加密  [str base64EncodedString]使用开源Base64.h分类文件加密
    NSString * str2 = [NSString stringWithFormat:@"Basic %@",[str base64EncodedString]];
    [request setValue:str2 forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            failure(error);
        } else {
            
            success(responseObject);
            
        }
    }];
    [dataTask resume];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
}

@end
