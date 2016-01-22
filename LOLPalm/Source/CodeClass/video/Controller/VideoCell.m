//
//  VideoCell.m
//  LOLPalm
//
//  Created by fanyanqing on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
}

-(UIImageView *)imgView
{
    if(!_imgView)
    {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height-30)];
//        _imgView.backgroundColor = [UIColor colorWithRed:arc4random()%1000/999.0 green:arc4random()%1000/999.0 blue:arc4random()%1000/999.0 alpha:1];
    }
    return _imgView;
}
-(UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame), CGRectGetWidth(self.imgView.frame), 30)];
        _titleLab.backgroundColor = [UIColor yellowColor];
    }
    return _titleLab;
}

-(void)setItem:(VideoItem *)item
{
    if (_item != item)
    {
        _item = nil;
        _item = item;
    }
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_item.pic_url]];
    self.titleLab.text = _item.name;
    NSLog(@"text:%@",_item.name);
}


@end
