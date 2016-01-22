//
//  InformationCollectionViewCell.m
//  LOLPalm
//
//  Created by 宋庆亮 on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "InformationCollectionViewCell.h"

@implementation InformationCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawView];
        
    }
    return self;
}

- (void)drawView{
    _imaView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.imaView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.goldLabel];
    
}

- (void)setInfor:(Information *)infor{
    if (_infor != infor) {
        _infor = nil;
        _infor = infor;
    }
    self.nameLabel.text = infor.title;
    [self.imaView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://box.dwstatic.com/skin/%@/%@_0.jpg",infor.enName,infor.enName]]];
    NSString *string = [infor.price substringFromIndex:5];
    NSString *string2 = [infor.price substringToIndex:4];
    self.pointLabel.text = string2;
    self.goldLabel.text = string;
    
    [string2 stringByReplacingOccurrencesOfString:@"," withString:@""];

    
    
}


- (void)awakeFromNib {
    // Initialization code
    // 每次布局的时候都完成全新的坐标计算
    //self.imaView.frame = self.contentView.bounds;

}

@end
