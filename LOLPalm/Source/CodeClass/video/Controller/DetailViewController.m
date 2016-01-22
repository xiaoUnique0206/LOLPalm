//
//  DetailViewController.m
//  LOLPalm
//
//  Created by fanyanqing on 16/1/22.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UIWebViewDelegate>

@property(strong,nonatomic)UIWebView *webView;

@end

@implementation DetailViewController

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"掌游宝";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.tabBarController.tabBar setHidden:YES];
    // Do any additional setup after loading the view.
    NSString *str = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:self.urlString] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",str);
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView.userInteractionEnabled = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"load error:%@",error);
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"didStart");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"didFinish");
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
