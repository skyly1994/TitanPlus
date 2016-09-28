//
//  DiscoverWebViewController.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/24.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "DiscoverWebViewController.h"

@interface DiscoverWebViewController ()
{
    UIWebView *webView;
}
@end

@implementation DiscoverWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
    [self cuatomNavigationbar];
}
-(void)cuatomNavigationbar{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    label.text = _name;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = label;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"redimage2.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    //self.navigationController.navigationBar.tintColor = [UIColor redColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 15, 20);
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_white@2x"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = item;
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createWebView{
    webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self.view addSubview:webView];
    
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
