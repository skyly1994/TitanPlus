
//
//  MatchViewController.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/13.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "MatchViewController.h"
#import "AFNetworking.h"
#import "MatchTableViewCell.h"
#import "MatchModel.h"
#import "YYModel.h"
#import "WXRefresh.h"
#import "HistoryViewController.h"
@class HistoryViewController;
@class MatchModel;
@class MatchTableViewCell;
@class AFHTTPSessionManager;
/*
 http://ballq.ttplus.cn/ttplus/soccer/v5/match_list/?etype=0
 
 http://app.ttplus.cn:1102/notice/list?&pagenum=0
 
 http://ballq.ttplus.cn/ttplus/soccer/v1/match/118399/history/
 */
@interface MatchViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSDictionary *_matchesDic;
    NSArray *_tournames;
    NSMutableArray *_modelArray;
}
@end

@implementation MatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCustomNavigationBar];
    [self createTableView];
    [self loadData];
}
- (void)createCustomNavigationBar{
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    label.text = @"比赛";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    
    self.navigationItem.titleView = label;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
//加载数据
-(void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = @"http://ballq.ttplus.cn/ttplus/soccer/v5/match_list/?etype=0";
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"%@",responseObject);
        NSDictionary *dataDic = responseObject[@"data"];
        NSArray *matches = dataDic[@"matches"];

//        NSArray *tournaments = dataDic[@"tournaments"];
        
//        NSMutableArray *mArray = [NSMutableArray array];
//        for (NSDictionary *dic in tournaments) {
//            NSArray *keys = [dic allKeys];
//            [mArray addObject:keys[0]];
//        }
//        NSArray *tourids = [mArray copy];
//       // NSLog(@"%@",tourids);
//        NSMutableArray *mArray2 = [NSMutableArray array];
//        for (int i = 0; i < tournaments.count; i++) {
//            NSDictionary *dic = tournaments[i];
//            NSString *tourname = dic[tourids[i]];
//            [mArray2 addObject:tourname];
//        }
//        NSArray *tournames = [mArray2 copy];
        //NSLog(@"%@",tournames);
        
        //解析matches
        _modelArray = [NSMutableArray array];
        
        
        
        NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
        NSMutableArray *mArray;
        for (NSDictionary *dic in matches) {
            mArray = mDic[dic[@"tourname"]];
            if (mArray == nil) {
                mArray = [NSMutableArray array];
                [mDic setValue:mArray forKey:dic[@"tourname"]];
            }
            [mArray addObject:dic];
        }
        _matchesDic = [mDic copy];
        _tournames = [[mDic allKeys] copy];
        
        
        for (int i = 0; i < _tournames.count; i++) {
            if (i == _tournames.count) {
                break;
            }
            NSArray *array = mDic[_tournames[i]];
            NSMutableArray *mArray = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in array) {
                MatchModel *model = [MatchModel yy_modelWithDictionary:dic];
                [mArray addObject:model];
            }
            [_modelArray addObject:mArray];
            
        }
        
        
        [_tableView reloadData];
        

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed");
    }];
}

//创建表视图
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 70;
    
    __weak MatchViewController *wSelf = self;
    [_tableView addPullDownRefreshBlock:^{
        __strong MatchViewController *strongSelf = wSelf;
        [strongSelf refreshData];
    }];
    [_tableView registerNib:[UINib nibWithNibName:@"MatchTableViewCell" bundle:nil] forCellReuseIdentifier:@"Matchcell"];
    [self.view addSubview:_tableView];
}
-(void)refreshData{
    [self loadData];
    _tableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 -49);
    [_tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
}
#pragma - mark UITableviewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _tournames.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *tourname = _tournames[section];
    NSArray *array = _matchesDic[tourname];

//    NSArray *modelarray =  _modelArray[section];
//    for (MatchModel *model in modelarray) {
//        NSLog(@"%@",model.tourname);
//    }
    return array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MatchTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Matchcell"];
    cell.model = _modelArray[indexPath.section][indexPath.row];
    //MatchModel *model = _modelArray[indexPath.section][indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma - mark UITabelViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 100, 30)];
    label.text = _tournames[section];
    label.font = [UIFont systemFontOfSize:20];
    [view addSubview:label];
    
    return view;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MatchTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    HistoryViewController *VC = [[HistoryViewController alloc]init];
    VC.model = cell.model;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
#pragma - mark scrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == (UIScrollView *)_tableView) {
        CGFloat sectionHeaderHeight = 40;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    
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
