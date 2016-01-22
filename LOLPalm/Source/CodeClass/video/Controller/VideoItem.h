//
//  VideoItem.h
//  LOLPalm
//
//  Created by fanyanqing on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoItem : NSObject

@property(strong,nonatomic)NSString *desc;
@property(strong,nonatomic)NSString *Id;
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *pic;
@property(strong,nonatomic)NSString *pic_url;

@end

@interface VideoCate : NSObject

@property(strong,nonatomic)NSString *Id;
@property(strong,nonatomic)NSString *name;

@end