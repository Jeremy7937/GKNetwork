//
//  GKNetwork.h
//  HttpsDemo
//
//  Created by 郭凯 on 16/4/19.
//  Copyright © 2016年 郭凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Base64.h"

@interface GKNetwork : NSObject <NSURLConnectionDelegate>

+ (instancetype)sharedInstance;

- (void)requestUrl:(NSString *)url param:(NSDictionary *)param isGetMethod:(BOOL)isGet completionBlockSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
