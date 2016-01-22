//
//  SecondViewController.m
//  LOLPalm
//
//  Created by lanou3g on 16/1/22.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UIWebViewDelegate>

@property(strong ,nonatomic)UIWebView *myWebView;
@property(strong ,nonatomic)UIActivityIndicatorView *activity;

@end

@implementation SecondViewController

#define secondURLStr  @"http://lol.zhangyoubao.com/mobiles/item/"

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myWebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.myWebView.delegate = self;
    
    [self.myWebView setScalesPageToFit:YES];
    [self.view addSubview:self.myWebView];

    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",secondURLStr,_model_id]]];
    [self.myWebView loadRequest:request];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
   
    self.activity = [[UIActivityIndicatorView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.activity];
    self.activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.activity.color = [UIColor blueColor];
    [self.activity startAnimating];
}



-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.activity stopAnimating];
    [self.activity removeFromSuperview];
    [self.myWebView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth = 300.0;" // UIWebView中显示的图片宽度
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [self.myWebView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
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
