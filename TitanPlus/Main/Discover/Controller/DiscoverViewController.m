//
//  DiscoverViewController.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/13.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "DiscoverViewController.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "DiscoverModel.h"
#import "DiscoverWebViewController.h"
#define kReadButtonWidth (kScreenWidth/4 - 40)
#define kImageViewWidth (kScreenWidth/3)
@class DiscoverWebViewController;
@class DiscoverModel;
@class AFHTTPSessionManager;
@interface DiscoverViewController ()
{
    NSArray *_topImageNameArr;
    NSArray *_readType;
    NSArray *_modelArray;
    UIView *bottomView;
}
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self createUI];
}
-(void)createUI{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner"] forBarMetrics:UIBarMetricsDefault];
    [self createMainView];
}
-(void)createMainView{
    //上面视图
    UIView *readView = [[UIView alloc]initWithFrame:CGRectMake(20, 64, kScreenWidth - 40, kReadButtonWidth + 20)];
    [self.view addSubview:readView];
    for (int i = 0; i < _topImageNameArr.count; i++) {
        UIButton *readButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        readButton.backgroundColor = [UIColor redColor];
        readButton.frame = CGRectMake(i * (kReadButtonWidth + 40), 0, kReadButtonWidth, kReadButtonWidth + 20);
        readButton.tag = i + 100;
        [readButton setTitle:_readType[i] forState:UIControlStateNormal];
        [readButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        readButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [readButton setImageEdgeInsets:UIEdgeInsetsMake(-20, 0, 0, -25)];
        [readButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, -20, 0)];
        if (i == 1) {
            [readButton setImageEdgeInsets:UIEdgeInsetsMake(-20, 0, 0, -30)];
            [readButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, -20, 0)];
        }
        [readButton setImage:[UIImage imageNamed:_topImageNameArr[i]] forState:UIControlStateNormal];
        [readButton addTarget:self action:@selector(readButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [readView addSubview:readButton];
    }
    
    //中间label
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, readView.bottom, kScreenWidth, 40)];
    [self.view addSubview:label];
    label.text = @" 战略合作";
    label.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    //下面视图
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, label.bottom, kScreenWidth, kScreenHeight - label.bottom - 49)];
    //bottomView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bottomView];
    
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 3; j++) {
            CGFloat width = kScreenWidth/3 - 10;
            CGFloat height = bottomView.height/4 - 20;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i * 3 + j + 200;
            //[button setTitle:[NSString stringWithFormat:@"%ld",button.tag] forState:UIControlStateNormal];
            //button.backgroundColor = [UIColor cyanColor];
            button.frame = CGRectMake(j * (width + 10), i * (height + 20), width, height);
//            [button addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:button];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 20)];
            label.tag = i * 3 + j + 300;
            
            label.frame = CGRectMake(button.frame.origin.x, button.bottom, button.width, 20);
            [bottomView addSubview:label];
            
        }
    }
    
}
-(void)bottomBtnAction : (UIButton *)button{
    NSInteger index = button.tag - 200;
    DiscoverModel *model = _modelArray[index];
    DiscoverWebViewController *webViewCtrl = [[DiscoverWebViewController alloc]init];
    webViewCtrl.url = model.url;
    webViewCtrl.name = model.name;
    webViewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewCtrl animated:YES];
}
-(void)readButtonAction:(UIButton *)readButton{

}
- (void)loadData{
    
    /*
     {
     icon = "http://resource.ttplus.cn/product/leshitiyu.png";
     id = 1;
     name = "12\U5f3a\U8d5b";
     url = "http://12.lesports.com/?ch=zchaottzl";
     }
     */
    _readType = @[@"读报",@"热文榜",@"活动",@"搜索"];
    _topImageNameArr = @[@"find_read@2x",@"find_rank@2x",
                         @"find_active@2x",@"find_search@2x"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = @"http://www1.ttplus.cn/product.json";
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = responseObject[@"list"];
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            DiscoverModel *model = [DiscoverModel yy_modelWithDictionary:dic];
            [mArray addObject:model];
        }
        _modelArray = [mArray copy];
        
        
        //设置图片
        for (int i = 0; i < _modelArray.count; i++) {
            DiscoverModel *model = _modelArray[i];
            NSInteger tag = i + 200;
            UIButton *button = [bottomView viewWithTag:tag];
            
            //异步加载图片
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager downloadImageWithURL:[NSURL URLWithString:model.icon] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
                [button setBackgroundImage:image forState:UIControlStateNormal];
            }];
            
            
            [button addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];

            UILabel *label = [bottomView viewWithTag:i + 300];
            label.text = model.name;
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed");
    }];
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
