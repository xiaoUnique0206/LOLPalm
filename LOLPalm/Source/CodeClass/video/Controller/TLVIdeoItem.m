//
//  TLVIdeoItem.m
//  LOLPalm
//
//  Created by fanyanqing on 16/1/22.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "TLVIdeoItem.h"

@implementation TLVIdeoItem

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.Id = value;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"name:%@ title:%@",_desc,_title];
}

@end
