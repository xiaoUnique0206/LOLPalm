//
//  VideoCollectionViewController.m
//  LOLPalm
//
//  Created by 宋庆亮 on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "VideoCollectionViewController.h"

@interface VideoCollectionViewController ()

@property(strong,nonatomic)NSArray *cateArr;
@property(strong,nonatomic)NSArray *dataArr;

@end

@implementation VideoCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self)
    {
        self.navigationItem.title = @"视频";
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"视频" image:[UIImage imageNamed:@"iconfont-ordinaryvideo"] tag:1001];
        self.tabBarController.tabBar.tintColor = [UIColor blueColor];
        self.cateArr = [NSArray array];
        [self loadData];
    }
    return self;
}

- (void)loadData
{
//    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:VideoUpdateTime_URL]];
//    NSError *error = nil;
//    NSDictionary *timeList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//    if (error)
//    {
//        NSLog(@"timeList error: %@",error);
//    }
//    else
//    {
//        NSArray *dataArr = [timeList objectForKey:@"data"];
//        NSMutableArray *timeArr = [NSMutableArray array];
//        for (NSDictionary *subDict in dataArr)
//        {
//            NSDictionary *nDict = [[NSDictionary alloc] init];
//            [nDict setValue:[subDict objectForKey:@"updated"] forKey:[subDict objectForKey:@"id"]];
//            [timeArr addObject:nDict];
//        }
//        
//    }
        [[DataRequestTool shareData] getDataWithURL:VideoLog_URL andBlock:^(NSData *data) {
            NSError *dataError = nil;
            NSDictionary *logDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&dataError];
            if (dataError)
            {
                NSLog(@"data request error:%@",dataError);
            }
            else
            {
               NSArray *mainArr = [logDict objectForKey:@"data"];
                NSMutableArray *cateArr = [NSMutableArray array];
                NSMutableArray *dataArr = [NSMutableArray array];
                for (NSDictionary *sDict in mainArr)
                {
                    VideoCate *cate = [[VideoCate alloc] init];
                    [cate setValuesForKeysWithDictionary:sDict];
                    [cateArr addObject:cate];
                    NSLog(@"cate:%@",cate);
                    NSArray *itemArr = [sDict objectForKey:@"catword_id"];
                    NSMutableArray *itemsArr = [NSMutableArray array];
                    for (NSDictionary *subDict in itemArr)
                    {
                        VideoItem *item = [[VideoItem alloc] init];
                        [item setValuesForKeysWithDictionary:subDict];
                        [itemsArr addObject:item];
                    }
                    NSArray *subDataArr = itemsArr;
                    [dataArr addObject:subDataArr];
                }
                self.dataArr = dataArr;
                self.cateArr = cateArr;
                }
        }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor]};
    
//    self.collectionView.backgroundColor = [UIColor cyanColor];
    [self.collectionView registerClass:[VideoCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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

//- (CGSize)collectionView:(UICollectionView *) collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
//{
//
//    return CGSizeMake(120, 100);
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    NSLog(@"section:%ld",self.dataArr.count);
    return self.dataArr.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items

    return [self.dataArr[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    VideoItem *item = [[VideoItem alloc] init];
    item = self.dataArr[indexPath.section][indexPath.row];
    cell.item = item;
    return cell;
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TlevelUITableViewController *tltvc = [[TlevelUITableViewController alloc] init];
    VideoItem *item = [[VideoItem alloc] init];
    item = self.dataArr[indexPath.section][indexPath.row];
    tltvc.item = item;
    VideoCate *cate = [[VideoCate alloc] init];
    cate = self.cateArr[indexPath.section];
    tltvc.cateID = cate.Id;
    [self.navigationController pushViewController:tltvc animated:YES];
}

@end
