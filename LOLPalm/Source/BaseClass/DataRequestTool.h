//
//  DataRequestTool.h
//  GeekNews
//
//  Created by fanyanqing on 16/1/18.
//  Copyright © 2016年 tusm. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^myblock)(NSData *data);

@interface DataRequestTool : NSObject

+ (DataRequestTool *)shareData;

- (void)getDataWithURL:(NSString *)urlString andBlock:(myblock)block;

@end
