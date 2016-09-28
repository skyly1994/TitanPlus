//
//  ChannelWebViewController.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/23.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "ChannelWebViewController.h"
#import "NewsViewController.h"
@class NewsViewController;
@interface ChannelWebViewController ()
{
    UIWebView *webview;
}
@end

@implementation ChannelWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
}
- (void)createWebView{
    webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self.view addSubview:webview];
    //[self configWebview];
}

-(void)configWebview{

    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, 20, 30, 30);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"black_back@2x"] forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 15;
    backBtn.clipsToBounds = YES;
    backBtn.layer.masksToBounds = YES;
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [webview addSubview:backBtn];
    
    
}
-(void)backAction{
    //[self.navigationController popViewControllerAnimated:YES];
    NewsViewController *newsVC = [[NewsViewController alloc]init];
    [self.navigationController popToViewController:newsVC animated:YES];
    self.navigationController.navigationBarHidden = NO;
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
