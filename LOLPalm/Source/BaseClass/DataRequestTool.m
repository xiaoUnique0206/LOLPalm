//
//  DataRequestTool.m
//  GeekNews
//
//  Created by fanyanqing on 16/1/18.
//  Copyright © 2016年 tusm. All rights reserved.
//

#import "DataRequestTool.h"

static DataRequestTool *dataHandle = nil;

@implementation DataRequestTool

+ (DataRequestTool *)shareData
{
    if (dataHandle == nil)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            dataHandle = [[DataRequestTool alloc] init];
        });
    }
    return dataHandle;
}

- (void)getDataWithURL:(NSString *)urlString andBlock:(myblock)block
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"dataTask error:%@",error);
        }
        else
        {
            block(data);
        }
    }];
    [dataTask resume];
}

@end
