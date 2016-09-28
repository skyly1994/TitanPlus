//
//  MainTabBarController.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/13.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

-(instancetype)init{
    self = [super init];
    if (self) {
        [self configViewControllers];
        [self createCustomTabBar];
    }
    return self;
}
- (void)configViewControllers{
    NSArray *sbNameArr = @[@"News",@"Match",@"Discover",@"Center"];
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSString *sbName in sbNameArr) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:[NSBundle mainBundle]];
        UIViewController *navi = [sb instantiateInitialViewController];
        [mArray addObject:navi];
    }
    NSArray *viewControllers = [mArray copy];
    self.viewControllers = viewControllers;
}
- (void)createCustomTabBar{
    //移除原有标签栏按钮
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [subView removeFromSuperview];
        }
    }
    //创建自定义标签栏按钮
    NSArray *titles = @[@"新闻",@"比赛",@"发现",@"我的"];
    NSArray *imageNames = @[@"bottom_news@2x",@"bottom_match@2x",@"bottom_find@2x",@"bottom_user@2x"];
    NSArray *selectImageNames = @[@"bottom_news_selected@2x",@"bottom_match_selected@2x",@"bottom_find_selected@2x",@"bottom_user_selected@2x"];
    CGFloat btnWidth = kScreenWidth / 4;
    for (int i = 0; i < 4; i++) {
        NSString *title = titles[i];
        NSString *imageName = imageNames[i];
        NSString *selectImageName = selectImageNames[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * btnWidth, 0, btnWidth, 49);
        button.tag = i + 100;
        if (i == 0) {
            button.selected = YES;
        }
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
        
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -55, -30, -30)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 10, -30)];
        
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:1] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        

        
        [self.tabBar addSubview:button];
        
        
        
        
    }
}
- (void)btnAction : (UIButton *)button{
    self.selectedIndex = button.tag - 100;
    for (int i = 0; i < 4; i++) {
        UIButton *btn = (UIButton *)[self.tabBar viewWithTag:i + 100];
        btn.selected = NO;
    }
    button.selected = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
