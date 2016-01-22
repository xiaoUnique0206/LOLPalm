//
//  VideoTableViewCell.h
//  LOLPalm
//
//  Created by lanou3g on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoTableViewCell : UITableViewCell

@property(strong, nonatomic)InfomationModel *infoModel;

@property (weak, nonatomic) IBOutlet UIImageView *picImgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
