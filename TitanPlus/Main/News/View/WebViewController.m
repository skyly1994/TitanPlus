//
//  WebViewController.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/17.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
-(instancetype)initWithUrl:(NSString *)urlStr{
    self = [super init];
    if (self) {
        _url = [NSURL URLWithString:urlStr];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
}
-(void)createWebView{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:_url]];
    [self.view addSubview:webView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, 20, 30, 30);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"black_back@2x"] forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 15;
    backBtn.clipsToBounds = YES;
    backBtn.layer.masksToBounds = YES;
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
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
