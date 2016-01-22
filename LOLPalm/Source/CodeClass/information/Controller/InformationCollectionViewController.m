//
//  InformationCollectionViewController.m
//  LOLPalm
//
//  Created by 宋庆亮 on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "InformationCollectionViewController.h"

@interface InformationCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation InformationCollectionViewController

static NSString * const reuseIdentifier = @"Cell";


- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.navigationItem.title = @"英雄";
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"英雄" image:[UIImage imageNamed:@"iconfont-zixun"] tag:1001];
        self.tabBarController.tabBar.tintColor = [UIColor blueColor];
        self.navigationController.navigationBar.barTintColor =[UIColor blackColor];
        self.tabBarController.tabBar.tintColor = [UIColor blueColor];
        [self draw];
    }
    return self;
}
- (void)draw{
    [[DataRequestTool shareData]getDataWithURL:InformationAllURL andBlock:^(NSData *data) {
        NSError *dataError = nil;
        NSDictionary *logDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&dataError];
        self.dataArray = [NSMutableArray array];

        if (dataError) {
            NSLog(@"data request error:%@",dataError);
            
        }else{
            NSMutableArray *array = [logDict objectForKey:@"all"];
            
            for (NSDictionary *dic in array) {
                
                Information *infor = [Information new];
                //NSLog(@"====%@",infor);
                [infor setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:infor];
                
            }            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor =[UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor]};
    
    self.collectionView.backgroundColor = [UIColor magentaColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"InformationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

    // Do any additional setup after loading the view.
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        return CGSizeMake(self.view.bounds.size.width/4, self.view.bounds.size.width/2.5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>
// 分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}
// 每个分区含有items个数

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InformationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
    cell.imaView.backgroundColor = [UIColor blueColor];
    Information *infor = self.dataArray[indexPath.item];
    cell.infor = infor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    InformationDetailTableViewController *inforDetailTVC = [[InformationDetailTableViewController alloc]initWithStyle:(UITableViewStylePlain)];
    Information *infor = self.dataArray[indexPath.item];
    inforDetailTVC.infor = infor;
    [self.navigationController pushViewController:inforDetailTVC animated:YES];
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
