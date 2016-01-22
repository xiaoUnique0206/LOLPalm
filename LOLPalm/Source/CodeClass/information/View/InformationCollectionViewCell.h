//
//  InformationCollectionViewCell.h
//  LOLPalm
//
//  Created by 宋庆亮 on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Information.h"
@interface InformationCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imaView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property(nonatomic,strong)Information *infor;

@end
