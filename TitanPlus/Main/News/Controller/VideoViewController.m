//
//  VideoViewController.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/18.
//  Copyright © 2016年 陆斌. All rights reserved.
//

/*
 // URL链接:http://app.ttplus.cn:1102/video/qupai/list?pagenum=0
 
 // 返回数据
 NSArray *array = responseObject[@"rows"];
 
 
 "clientuser_id" = 7726;
 count = 1;
 createtime = 1474081495000;
 details = "";
 duration = "20.000000";
 htmlurl = "http://resource.ttplus.cn//publish/qupaivideo/cc110010-5357-4125-a8b8-94463f270f4e.html";
 icon = "http://img.user.ttplus.cn//user/headphoto/7726_1469433077762.jpg";
 id = 20937;
 nickname = "ttplus   ";
 source = ttplus;
 thumbnail = "http://live.video.ttplus.cn/v/cc110010-5357-4125-a8b8-94463f270f4e.jpg";
 title = "\U6613\U5efa\U8054\U5c55\U793a\U6e56\U4eba11\U53f7\U7403\U8863";
 videoid = "cc110010-5357-4125-a8b8-94463f270f4e";
 videourl = "http://live.video.ttplus.cn/v/cc110010-5357-4125-a8b8-94463f270f4e.mp4";
 */
#import "VideoViewController.h"
#import "AFNetworking.h"
#import "VideoTableViewCell.h"
#import "VideoModel.h"
#import "YYModel.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@class VideoModel;
@class VideoTableViewCell;
@class AFHTTPSessionManager;
@interface VideoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_modelArray;
    NSInteger _index;
}
@end

@implementation VideoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCustomNavi];
    [self createTableView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadDataWithPageNum:@"0"];
    
    _index = 0;
}
//数据加载
-(void)loadDataWithPageNum : (NSString *)pageNum{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = @"http://app.ttplus.cn:1102/video/qupai/list?";
    NSDictionary *parameters = @{@"pagenum" : pageNum};
    [manager GET:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        _dataArray = [responseObject[@"rows"] mutableCopy];
        [self configModel];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed");
    }];
}
-(void)configModel{
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSDictionary *dic in _dataArray) {
        VideoModel *model = [VideoModel yy_modelWithDictionary:dic];
        [mArray addObject:model];
    }
    _modelArray = [mArray mutableCopy];
    [_tableView reloadData];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
//导航栏自定义
-(void)createCustomNavi{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    label.text = @"在现场";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = label;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:0 blue:0.1 alpha:1.0];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button setBackgroundImage:[UIImage imageNamed:@"video_return@2x"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = item;
}
//创建tableView
-(void)createTableView{

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.rowHeight = 224;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"VideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];
    
    [self.view addSubview:_tableView];
    [self refeshAndLoadMoreData];
}
#pragma - mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
    cell.model = _modelArray[indexPath.row];
    return cell;
}
#pragma - mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoTableViewCell *cell = (VideoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSURL *videoUrl = cell.videoUrl;
    if (videoUrl) {
       [self playVideoWithUrl:videoUrl];
    }
}
-(void)playVideoWithUrl : (NSURL *)url{
    AVPlayerViewController *playCtrl = [[AVPlayerViewController alloc]init];
    AVPlayer *player = [[AVPlayer alloc]initWithURL:url];
    playCtrl.player = player;
    playCtrl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [playCtrl.player play];
    [self presentViewController:playCtrl animated:YES completion:nil];
}
#pragma - mark 下拉刷新，上拉加载更多
-(void)refeshAndLoadMoreData{
    __weak VideoViewController *wSelf = self;
    [_tableView addPullDownRefreshBlock:^{
        __strong VideoViewController *strongSelf = wSelf;
        [strongSelf loadNewData];
    }];
    
    [_tableView addInfiniteScrollingWithActionHandler:^{
        __strong VideoViewController *strongSelf = wSelf;
        [strongSelf loadMoreData];
    }];
}
-(void)loadNewData{
    _index = 0;
    [self loadDataWithPageNum:@"0"];
    _tableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    [_tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
}
-(void)loadMoreData{
    _index++;

    [self loadMoreDataWithPageNum:[NSString stringWithFormat:@"%ld",_index]];
    [_tableView.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
    [_tableView reloadData];
}

-(void)loadMoreDataWithPageNum : (NSString *)pageNum{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = @"http://app.ttplus.cn:1102/video/qupai/list?";
    NSDictionary *parameters = @{@"pagenum" : pageNum};
    [manager GET:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        _dataArray = [responseObject[@"rows"] mutableCopy];
        NSLog(@"%@",_dataArray);
        for (NSDictionary *dic in _dataArray) {
            VideoModel *model = [VideoModel yy_modelWithDictionary:dic];
            [_modelArray addObject:model];
        }
        
        //[_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed");
    }];
}

-(void)returnBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
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
