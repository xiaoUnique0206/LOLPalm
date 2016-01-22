//
//  WuTableView.h
//  LOLPalm
//
//  Created by lanou3g on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WuTableView : UITableView

@property(strong ,nonatomic)NSMutableArray *dataArray;
@property(assign ,nonatomic)NSUInteger pageNumber;


@end
