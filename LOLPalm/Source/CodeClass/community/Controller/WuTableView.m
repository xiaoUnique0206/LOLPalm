//
//  WuTableView.m
//  LOLPalm
//
//  Created by lanou3g on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "WuTableView.h"

@implementation WuTableView

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(NSUInteger)pageNumber{
    if (_pageNumber == 0) {
        _pageNumber = 1;
    }
    return _pageNumber;
}


@end
