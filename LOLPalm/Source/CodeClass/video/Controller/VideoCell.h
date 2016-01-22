//
//  VideoCell.h
//  LOLPalm
//
//  Created by fanyanqing on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCell : UICollectionViewCell

@property(strong,nonatomic)UIImageView *imgView;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)VideoItem *item;


@end
