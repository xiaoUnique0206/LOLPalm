//
//  VideoItem.m
//  LOLPalm
//
//  Created by fanyanqing on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "VideoItem.h"

@implementation VideoItem

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.Id = value;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"name:%@ desc:%@",_name,_desc];
}

@end

@implementation VideoCate

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.Id = value;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"name:%@ id:%@ ",_name,_Id];
}

@end
