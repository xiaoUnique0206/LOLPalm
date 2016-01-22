//
//  CommunityViewController.m
//  LOLPalm
//
//  Created by lanou3g on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "CommunityViewController.h"

@interface CommunityViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

//存wuTableView
@property(strong ,nonatomic)NSMutableArray *wuTableViewArray;
@property(strong ,nonatomic)UIScrollView   *scroll;

//当前的scrollView对应的页数
@property(assign ,nonatomic)NSInteger      currentPage;
@property(strong ,nonatomic)UIButton       *currentButton;


@end

static NSString * const normalCell = @"registNormalCell";
static NSString * const videoCell = @"registhVideoCell";

@implementation CommunityViewController

#define kscreenWidth  [UIScreen mainScreen].bounds.size.width
#define kscreenHeight [UIScreen mainScreen].bounds.size.height
#define kButtonCount  4
#define kButtonHeight 30
#define kHeadViewHeight kscreenWidth/5


#define kFirstURLStr  @"http://lol.zhangyoubao.com/apis/rest/ItemsService/lists?catid="
#define kCatid        @[@10178,@10000,@10006,@10179]
#define kSecondURLStr @"&cattype=news&page="
#define kAppendStr    @"&t_=1453296397039&p_=23462&v_=400705"


//button      tag: 100~103
//wuTableView tag: 200~203


- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.navigationItem.title = @"新闻资讯";
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"资讯" image:[UIImage imageNamed:@"iconfont-zixun"] tag:1001];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tabBarController.tabBar.tintColor = [UIColor blueColor];
    self.navigationController.navigationBar.barTintColor =[UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [self darwView];
    self.currentPage = 0;
    [self selectButtonAction:(UIButton*)[self.view viewWithTag:100]];
    
}



-(void)darwView{

    self.automaticallyAdjustsScrollViewInsets = NO;
    //scroll初始化  
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame)+ kButtonHeight, kscreenWidth,kscreenHeight - kButtonHeight - self.tabBarController.tabBar.bounds.size.height)];
    self.scroll.contentSize = CGSizeMake(kscreenWidth * kButtonCount, 0);
    self.scroll.pagingEnabled = YES;
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.bounces = NO;
    self.scroll.delegate = self;
    [self.view addSubview:self.scroll];
    
    //标题button
    NSArray *buttonArray = @[@"最新",@"新闻",@"赛事",@"娱乐"];
    for (int i = 0; i <kButtonCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(kscreenWidth/kButtonCount *i, CGRectGetMaxY(self.navigationController.navigationBar.frame), kscreenWidth/kButtonCount, kButtonHeight);
        [button setTitle:buttonArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = 100+i;
        button.backgroundColor = [UIColor blackColor];
        button.tintColor = [UIColor clearColor];
        [button addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        WuTableView *wuTV = [[WuTableView alloc]initWithFrame:CGRectMake(kscreenWidth*i, 0, kscreenWidth, CGRectGetHeight(self.scroll.bounds)-self.navigationController.navigationBar.bounds.size.height)];
        wuTV.delegate = self;
        wuTV.dataSource = self;
        wuTV.tag = 200+i;
        [wuTV registerNib:[UINib nibWithNibName:@"NormalTableViewCell" bundle:nil] forCellReuseIdentifier:normalCell];
        [wuTV registerNib:[UINib nibWithNibName:@"VideoTableViewCell" bundle:nil] forCellReuseIdentifier:videoCell];
        wuTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestURLForTableView:wuTV];
        }];
        wuTV.rowHeight = UITableViewAutomaticDimension;
        wuTV.estimatedRowHeight = 70;
        [self.scroll addSubview:wuTV];
        [self.wuTableViewArray addObject:wuTV];
    }
}

-(void)requestURLForTableView:(WuTableView *)tableView{
    
    NSMutableArray *listArray = [[NSMutableArray alloc]initWithCapacity:10];
    NSURLSessionTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%ld%@",kFirstURLStr,[kCatid objectAtIndex:self.currentPage],kSecondURLStr,tableView.pageNumber,kAppendStr]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *tempDict in [dict objectForKey:@"data"]) {
            
            InfomationModel *infoModel = [InfomationModel new];
            [infoModel setValuesForKeysWithDictionary:tempDict];
            [listArray addObject:infoModel];
        }
        
        if (tableView.mj_header.isRefreshing && tableView.dataArray.count >0) {
            InfomationModel *lastModel = tableView.dataArray[0];
            for (InfomationModel *infoModel in listArray) {
                if ([infoModel.published intValue] > [lastModel.published intValue]) {
                    [tableView.dataArray addObject:infoModel];
                } else {
                    break;
                }
            }
        } else {
            [tableView.dataArray addObjectsFromArray:listArray];
        }
        
        NSLog(@"数组中数据个数为: %ld", tableView.dataArray.count);
        
        tableView.pageNumber ++;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [tableView.mj_header endRefreshing];
            [tableView.mj_footer endRefreshing];
            [tableView reloadData];
        });
        
    }];
    [dataTask resume];
}

//button 点击事件
-(void)selectButtonAction:(UIButton*)sender{
    if (sender != self.currentButton) {
        self.currentButton.selected = !self.currentButton.selected;
        self.currentButton.backgroundColor = [UIColor blackColor];
        self.currentButton = nil;
        self.currentButton = sender;
        self.currentButton.selected = !self.currentButton.selected;
        self.currentButton.backgroundColor = [UIColor blueColor];
    }
    self.currentPage = sender.tag - 100;
    [self.scroll setContentOffset:CGPointMake(kscreenWidth * self.currentPage, 0) animated:YES];
    if ([self.wuTableViewArray[self.currentPage] dataArray].count ==0) {
        
        [self loginRefresh:self.wuTableViewArray[self.currentPage]];
    }
}

//下拉刷新
-(void)loginRefresh:(WuTableView*)tableView{

    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //刷新解析第一个界面
        tableView.pageNumber = 1;
        [self requestURLForTableView:tableView];
        
    }];
    [tableView.mj_header beginRefreshing];
}

-(NSMutableArray *)wuTableViewArray{
    if (_wuTableViewArray == nil) {
        _wuTableViewArray = [[NSMutableArray alloc]init];
    }
    return _wuTableViewArray;
}

#pragma  mark --- tableView delegate  -------

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [[self.wuTableViewArray[self.currentPage] dataArray] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InfomationModel *infoModel = [[InfomationModel alloc]init];
    infoModel = [self.wuTableViewArray[self.currentPage] dataArray][indexPath.row];
    
    if ([infoModel.video_url isEqualToString:@""]) {
        
        NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCell forIndexPath:indexPath];
        cell.infoModel = infoModel;
        return cell;
        
    } else  {
        
        VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:videoCell forIndexPath:indexPath];
        cell.infoModel = infoModel;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    secondVC.model_id = [[self.wuTableViewArray[self.currentPage] dataArray][indexPath.row] info_id];
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark ---  scrollView delegate  ----

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.scroll) {
        
        CGPoint scrollPoint = self.scroll.contentOffset;
        self.currentPage = scrollPoint.x / kscreenWidth;
        [self selectButtonAction:(UIButton*)[self.view viewWithTag:100+self.currentPage]];
    }
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

@end




