//
//  TLVIdeoTableViewCell.m
//  LOLPalm
//
//  Created by fanyanqing on 16/1/22.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "TLVIdeoTableViewCell.h"

#define TLCELL_W (W-2*Gap)
#define TLCELL_H (((H-64)/6)-2*Gap)

@implementation TLVIdeoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self drawView];
    }
    return self;
}

- (void)drawView
{
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.subTitleLab];
    [self.contentView addSubview:self.timeLab];
}

-(UIImageView *)imgView
{
    if (!_imgView)
    {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(Gap, Gap, TLCELL_W/4, TLCELL_H)];
    }
    return _imgView;
}

-(UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame)+Gap, Gap, TLCELL_W/4*3, TLCELL_H/2)];
    }
    return _titleLab;
}

-(UILabel *)subTitleLab
{
    if (!_subTitleLab)
    {
        _subTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame)+Gap, CGRectGetMaxY(self.titleLab.frame)+Gap, TLCELL_W/2, TLCELL_H/2-Gap)];
    }
    return _subTitleLab;
}

- (UILabel *)timeLab
{
    if (!_timeLab)
    {
        _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.contentView.bounds)-10, CGRectGetMaxY(self.contentView.bounds)+30, 100, 30)];
    }
    return _timeLab;
}

-(void)setItem:(TLVIdeoItem *)item
{
    if (_item != item)
    {
        _item = nil;
        _item = item;
    }
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_item.pic_url]];
    self.titleLab.text = _item.title;
    self.subTitleLab.text = _item.desc;
    self.subTitleLab.font = [UIFont systemFontOfSize:13];
    long long int date = (long long int)[_item.published intValue];
    NSDate *pubDate = [NSDate dateWithTimeIntervalSince1970:date];
    NSString *timeStr = [NSString stringWithFormat:@"%@",pubDate];
    timeStr = [timeStr substringWithRange:NSMakeRange(5, 14)];
    self.timeLab.text = timeStr;
    self.timeLab.numberOfLines = 1;
    self.timeLab.font = [UIFont systemFontOfSize:12];
    
}
@end
