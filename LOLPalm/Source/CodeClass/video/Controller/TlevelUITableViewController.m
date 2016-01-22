//
//  TlevelUITableViewController.m
//  LOLPalm
//
//  Created by fanyanqing on 16/1/22.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "TlevelUITableViewController.h"

@interface TlevelUITableViewController ()

@property(strong,nonatomic)NSArray *dataArr;

@end

@implementation TlevelUITableViewController
static NSString *const identifer = @"bcdsvcfsasxsa";

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.navigationItem.title = @"专辑详情";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-download.png"] style:UIBarButtonItemStyleDone target:self action:@selector(downLoad:)];
    }
    return self;
}

- (void)downLoad:(UIBarButtonItem *)btn
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.dataArr = [NSArray array];
    [self loadData];
}

- (void)loadData
{
    NSLog(@"cate:%@ id:%@",self.cateID,self.item.Id);
    NSString *urlStr = [NSString stringWithFormat:@"http://lol.zhangyoubao.com/apis/rest/ItemsService/videos?catid=%d&catwordid=%d&page=1&t_=1453298570579&p_=4082&v_=400705&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=21&cha=baiduMartket&u_=&modle_=HTC+One&",[self.cateID intValue],[self.item.Id intValue]];
    NSLog(@"urlStr:%@",urlStr);
    [[DataRequestTool shareData] getDataWithURL:urlStr andBlock:^(NSData *data) {
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error)
        {
            NSLog(@"json serialization error:%@",error);
        }
        else
        {
            NSArray *arr = [dict objectForKey:@"data"];
            NSMutableArray *dataArr = [NSMutableArray array];
            for (NSDictionary *subDict in arr)
            {
                TLVIdeoItem *item = [[TLVIdeoItem alloc] init];
                [item setValuesForKeysWithDictionary:subDict];
                NSLog(@"item: %@",item);
                [dataArr addObject:item];
            }
            self.dataArr = dataArr;
        }
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [self loadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[TLVIdeoTableViewCell class] forCellReuseIdentifier:identifer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *dvc = [[DetailViewController alloc] init];
    TLVIdeoItem *item = [[TLVIdeoItem alloc] init];
    item = self.dataArr[indexPath.row];
    dvc.urlString = [NSString stringWithFormat:@"http://lol.zhangyoubao.com/mobiles/item/%d?v_=400705&size=middle&t=1453298666",[item.item_id intValue]];
    [self.navigationController pushViewController:dvc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (H-64)/6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLVIdeoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    
    // Configure the cell...
    TLVIdeoItem *item = [[TLVIdeoItem alloc] init];
    item = self.dataArr[indexPath.row];
    cell.item = item;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
