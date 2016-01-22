//
//  InfomationModel.m
//  LOLPalm
//
//  Created by lanou3g on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "InfomationModel.h"

@implementation InfomationModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([@"id" isEqualToString:key]) {
        
        _info_id = value;
    }
}



@end
