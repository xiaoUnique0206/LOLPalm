//
//  Information.h
//  LOLPalm
//
//  Created by 宋庆亮 on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Information : NSObject
@property(nonatomic,strong)NSString *cnName;// 俗名
@property(nonatomic,strong)NSString *enName;// 英文名
@property(nonatomic,strong)NSString *location;// 位置
@property(nonatomic,strong)NSString *price;// 价钱
@property(nonatomic,strong)NSString *rating;// 数据
@property(nonatomic,strong)NSString *title;// 名字
@property(strong,nonatomic)NSString *smallImg;
@end
@interface InforPicture : NSObject



@end