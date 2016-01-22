//
//  TLVIdeoTableViewCell.h
//  LOLPalm
//
//  Created by fanyanqing on 16/1/22.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLVIdeoTableViewCell : UITableViewCell

@property(strong,nonatomic)UIImageView *imgView;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *subTitleLab;
@property(strong,nonatomic)UILabel *timeLab;
@property(strong,nonatomic)TLVIdeoItem *item;

@end
