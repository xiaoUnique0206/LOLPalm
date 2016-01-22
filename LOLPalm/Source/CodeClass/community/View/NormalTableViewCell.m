//
//  NormalTableViewCell.m
//  LOLPalm
//
//  Created by lanou3g on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "NormalTableViewCell.h"

@implementation NormalTableViewCell

- (void)awakeFromNib {
    
}

-(void)setInfoModel:(InfomationModel *)infoModel{
    if (_infoModel != infoModel) {
        _infoModel = nil;
        _infoModel = infoModel;
    }
    self.titleLabel.text = _infoModel.title;
    self.descLabel.text = _infoModel.desc;
    if ([@"1" isEqualToString: [NSString stringWithFormat:@"%@",_infoModel.recommend]]) {
        self.hotImgView.hidden = NO;
    }
    NSDate *foundDate = [NSDate dateWithTimeIntervalSince1970:[_infoModel.published doubleValue]];
    foundDate = [foundDate dateByAddingTimeInterval:8*60*60];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat: @"MM-dd"];

    if ( [[formatter stringFromDate:foundDate] isEqualToString:[formatter stringFromDate:[NSDate date]]]){
        [formatter setDateFormat:@"hh:mm"];
        self.timeLabel.text = [NSString stringWithFormat:@"今天 %@",[formatter stringFromDate:foundDate]];
    } else {
        [formatter setDateFormat:@"MM-dd hh:mm"];
        self.timeLabel.text = [formatter stringFromDate:foundDate];
    }
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
