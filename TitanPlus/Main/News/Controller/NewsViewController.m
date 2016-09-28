//
//  NewsViewController.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/13.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "NewsViewController.h"
#import "CurrentTime.h"
#import "AFNetworking.h"
#import "NewsModel.h"
#import "YYModel.h"
#import "NewsTableViewCell.h"
#import "WebViewController.h"
#import "VideoViewController.h"
#import "ChannelTableView.h"
#import "InitModel.h"
#import "AppDelegate.h"
#define kChannelNum (_channels.count)
#define kChannelWidth 70
#define kTopScrollViewHeight 35
#define kChannelSpace 10
#define kPullDownBtnWidth (kTopScrollViewHeight/2)
@class InitModel;
@class ChannelTableView;
@class WebViewController;
@class CurrentTime;
@class NewsModel;
@class NewsTableViewCell;
@class VideoViewController;
@interface NewsViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *_Mainview;
    UIScrollView *_topScrollView;
    UIScrollView *_bottomScrollView;
    NSArray *_channels;
    NSString *_curretnTime;
    NSMutableArray *_dataArray;
    NSMutableArray *_modelArray;
    
    UITableView *tableView;
    CGFloat _cellHeight;
    NSInteger _index;
    
    NSArray *_topicArray;
    NSMutableDictionary *_sctionidDic;
    
    ChannelTableView *_channelTableView;
}
@end

@implementation NewsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _topicArray = @[@"",@"all",@"athletics",@"badminton",@"bk",
                    @"car",@"chess",@"esports",@"fb",@"innerfb",
                    @"interfb",@"olympic",@"sports"];

    

    [self currentTime];
    [self createCustomNavigationBar];
    [self createMainView];
    
    [self loadSctionid];
//    [self loadSctionpath];
}


//-(void)loadSctionpath{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:@"http://www1.ttplus.cn/init.json" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        //NSLog(@"%@",responseObject);
//        _topicArray = responseObject[@"topic"];
//        
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"failed");
//    }];
//}
-(void)loadSctionid{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://www1.ttplus.cn/sectionidurl.json" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        _sctionidDic = [responseObject mutableCopy];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed");
    }];
}
- (void)createMainView{
    
    _channels = @[@"头条",@"最新",@"24H",@"足球",
                  @"篮球",@"奥运",@"视频",@"中国足球",
                  @"国际足球",@"NBA",@"中国篮球",@"棋牌"];
    _Mainview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 49)];
    _Mainview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_Mainview];
    
    //上面滑动视图
    _topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopScrollViewHeight)];
    [_Mainview addSubview:_topScrollView];
    
/*
 在有导航控制器的view中添加UIScrollView时，
 要禁止上下滑动需将contentSize的y值设置为－100。
 不知道为什么。。。。。
 */
    _topScrollView.contentSize = CGSizeMake(kChannelNum * (kChannelWidth + kChannelSpace) + 50, -100);
    _topScrollView.delegate = self;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < kChannelNum; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topScrollView addSubview:button];
        button.frame = CGRectMake(i * kChannelWidth +(i+1)*kChannelSpace, -64, kChannelWidth, kTopScrollViewHeight);
        [button setTitle:_channels[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.tag = i + 100;
        [button addTarget:self action:@selector(channelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        if (i == 0) {
            button.selected = YES;
        }

    }
    //下拉按钮 menu_open_down@2x
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kTopScrollViewHeight, kTopScrollViewHeight)];
    view.center = CGPointMake(kScreenWidth - kTopScrollViewHeight / 2, kTopScrollViewHeight / 2);
    view.backgroundColor = [UIColor whiteColor];
    [_Mainview addSubview:view];
    
    UIButton *pullDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_Mainview addSubview:pullDownBtn];
    pullDownBtn.frame = CGRectMake(0, 0, kPullDownBtnWidth, kPullDownBtnWidth);
    pullDownBtn.center = view.center;
    pullDownBtn.backgroundColor = [UIColor whiteColor];
    [pullDownBtn setBackgroundImage:[UIImage imageNamed:@"menu_open_down@2x"] forState:UIControlStateNormal];
    
    //下面滑动视图
    
    
    _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _topScrollView.bottom, kScreenWidth, _Mainview.height - _topScrollView.height)];
    [_Mainview addSubview:_bottomScrollView];
    _bottomScrollView.contentSize = CGSizeMake(kScreenWidth * (_topicArray.count-1), 0);
    _bottomScrollView.backgroundColor = [UIColor clearColor];
    _bottomScrollView.showsHorizontalScrollIndicator = NO;
    _bottomScrollView.showsVerticalScrollIndicator = NO;
    _bottomScrollView.pagingEnabled = YES;
    _bottomScrollView.delegate = self;
    [self loadNewsData];
    [self createTableView];
    [self createChannelTableView];

    
}
-(void)createChannelTableView{
    for (int i = 1; i < 12; i++) {
        ChannelTableView *tbView = [[ChannelTableView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, _bottomScrollView.height) style:UITableViewStylePlain];
        tbView.tag = 100 + i;
        NSNumber *number = [NSNumber numberWithInteger:tbView.tag];
        [self performSelector:@selector(loadInitDataWithIndex:) withObject:number afterDelay:1];
        [_bottomScrollView addSubview:tbView];
    }
}
-(void)loadInitDataWithIndex : (NSNumber *)number{

    NSInteger tag = [number integerValue];
    NSInteger index = tag - 100;
    if (index > (_topicArray.count - 1)) {
        return;
    }
   // NSDictionary *dic = _topicArray[index];
    NSString *sctionPath = _topicArray[index];
   // NSString *name = dic[@"name"];
    NSInteger sctionidInt = [_sctionidDic[sctionPath] integerValue];
    NSString *sctionid = [NSString stringWithFormat:@"%ld",sctionidInt];
    
    ChannelTableView *tbView =(ChannelTableView *) [_bottomScrollView viewWithTag:tag];
    [tbView loadDataWithSctionpath:sctionPath sctionid:sctionid];

}
//创建表示图
-(void)createTableView{
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _bottomScrollView.height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"newsCell"];
    [_bottomScrollView addSubview:tableView];
    
    __weak NewsViewController *weakSelf = self;
   
    //刷新数据
    [tableView addPullDownRefreshBlock:^{
         __strong NewsViewController *strongSelf = weakSelf;
        [strongSelf pullDownRefresh];
    }];
    [tableView addInfiniteScrollingWithActionHandler:^{
        __strong NewsViewController *strongSelf = weakSelf;
        [strongSelf pullUpRefresh];
    }];
}
#pragma mark - scrollViewdelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _bottomScrollView) {
        NSInteger x = _bottomScrollView.contentOffset.x;
        NSInteger pageNum = (NSInteger)(x / kScreenWidth);
        //buttonTag : i + 100;
        for (int i = 0; i < _channels.count; i++) {
            UIButton *button = (UIButton *)[_topScrollView viewWithTag:i + 100];
            button.selected = NO;
        }
        UIButton *selectBtn = (UIButton *)[_topScrollView viewWithTag:pageNum + 100];
        selectBtn.selected = YES;
        CGFloat scrollWidth = pageNum*(kChannelWidth + kChannelSpace) - kScreenWidth/2;
        //NSLog(@"%f",scrollWidth);
        if (scrollWidth > 0) {
            [UIView animateWithDuration:0.25 animations:^{
                _topScrollView.contentOffset = CGPointMake(scrollWidth, -64);
            }];
        }else if(scrollWidth < -150){
            [UIView animateWithDuration:0.25 animations:^{
                _topScrollView.contentOffset = CGPointMake(0, -64);
            }];
        }
        
    }
}
#pragma mark - tableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
    cell.model = _modelArray[indexPath.row];
    cell.time = _curretnTime;
    _cellHeight = cell.cellHeight;
    return cell;
}
#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *model = _modelArray[indexPath.row];
    NSString *urlStr = model.shareurl;
    WebViewController *wbCtrl = [[WebViewController alloc]initWithUrl:urlStr];
    self.navigationController.navigationBarHidden = YES;
    wbCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wbCtrl animated:YES];
}
//获取当前时间
-(void)currentTime{
    CurrentTime *ct = [[CurrentTime alloc]init];
    NSInteger year = ct.year;
    NSInteger month = ct.month;
    NSInteger day = ct.day;
    _curretnTime = [NSString stringWithFormat:@"%ld-%02ld-%02ld",year,month,day];
}
//数据加载
-(void)loadNewsData{
    
    NSMutableArray *mArray = [NSMutableArray array];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"http://www1.ttplus.cn/publish/app/list//day/%@.json",_curretnTime];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"%@",responseObject);
        _dataArray = [responseObject[@"datas"] mutableCopy];
        for (NSDictionary *dic in _dataArray) {
            NewsModel *model = [NewsModel yy_modelWithDictionary:dic];
            model.time = _curretnTime;
            [mArray addObject:model];
        }
        _modelArray = [mArray mutableCopy];
        [tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed");
    }];
}
#pragma mark - 下拉刷新，下拉加载
//下拉刷新

-(void)pullDownRefresh{
    [self loadNewsData];
    _index = 1;
    [tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
}
//上拉加载
-(void)loadMoreData{
    //获取上一个时间
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSDate *nowDate = [NSDate date];
    NSTimeInterval time = [nowDate timeIntervalSince1970];
    NSTimeInterval lastTime = time - 24 * 60 * 60 * _index;
    NSDate *lastDate = [NSDate dateWithTimeIntervalSince1970:lastTime];
    NSString *lastDateStr = [formatter stringFromDate:lastDate];
    _index++;
    //加载数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"http://www1.ttplus.cn/publish/app/list//day/%@.json",lastDateStr];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        _dataArray = [responseObject[@"datas"] mutableCopy];
        
        for (NSDictionary *dic in _dataArray) {
            NewsModel *model = [NewsModel yy_modelWithDictionary:dic];
            model.time = lastDateStr;
            [_modelArray addObject:model];
        }
        
        [tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed");
    }];
    
}

-(void)pullUpRefresh{
    [self loadMoreData];
    [tableView.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
}

//频道按钮事件
-(void)channelButtonAction : (UIButton *)button{
    for (int i = 0; i < kChannelNum; i++) {
        UIButton *btn = (UIButton *)[_topScrollView viewWithTag:i + 100];
        btn.selected = NO;
    }
    button.selected = YES;
    [UIView animateWithDuration:0.25 animations:^{
        _bottomScrollView.contentOffset = CGPointMake(kScreenWidth * (button.tag - 100), 0);
    }];
    
}
//自定义导航栏
- (void)createCustomNavigationBar{
    //标题
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80,32)];
    titleImageView.image = [UIImage imageNamed:@"top_logo_center@2x"];
    self.navigationItem.titleView = titleImageView;
    //左边按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 32, 32);
    leftButton.layer.cornerRadius = 16;
    leftButton.layer.masksToBounds = YES;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"guess@2x"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    //右边按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:@selector(videoPlayAction) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 32, 32);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"tv@2x"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)videoPlayAction{
    VideoViewController *videoCtrl = [[VideoViewController alloc]init];
    videoCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:videoCtrl animated:YES];
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
