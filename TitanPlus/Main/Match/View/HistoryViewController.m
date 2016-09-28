//
//  HistoryViewController.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/20.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "HistoryViewController.h"
#import "DetailView.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "HistoryTableViewCell.h"
#import "PlayerModel.h"
#import "LineupHeaderView.h"
#import "LineupTableViewCell.h"
@class LineupTableViewCell;
@class LineupHeaderView;
@class HistoryTableViewCell;
@class AFHTTPSessionManager;
@class DetailView;
@class PlayerModel;
@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    DetailView *_detailView;
    UIView *_topView;
    UIScrollView *_scrollView;
    NSArray *_dataArray;
    
    NSString *_awayFormatiom;
    NSArray *_awayMap;
    
    NSString *_homeFormation;
    NSArray *_homeMap;
    
    NSArray *_awayPlayerModels;
    NSArray *_homePlayerModels;
    
    NSArray *_awayAndHomeModelArray;
}
@end

@implementation HistoryViewController
//http://ballq.ttplus.cn/ttplus/soccer/v1/match/147487/lineups/
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createMainView];
    [self loadHistoryData];
    [self loadLineupData];
}
-(void)loadHistoryData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://ballq.ttplus.cn/ttplus/soccer/v1/match/%@/history/",self.model.eid];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"%@",responseObject);
        NSMutableArray *mArray = [NSMutableArray array];
        NSDictionary *dic = responseObject[@"data"];
        NSArray *all_meetings = dic[@"all_meetings"];
        
        NSDictionary *last_matches = dic[@"last_matches"];
        NSArray *away_team = last_matches[@"away_team"];
        NSArray *home_team = last_matches[@"home_team"];
        
        [mArray addObject:all_meetings];
        [mArray addObject:away_team];
        [mArray addObject:home_team];
        _dataArray = [mArray copy];
        UITableView *historyTableView = (UITableView *)[_scrollView viewWithTag:201];
        [historyTableView reloadData];
//        NSLog(@"%@",all_meetings);
//        NSLog(@"%@",away_team);
//        NSLog(@"%@",home_team);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed");
    }];
}
-(void)loadLineupData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://ballq.ttplus.cn/ttplus/soccer/v1/match/%@/lineups/",self.model.eid];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"%@",responseObject);
        
        if ([responseObject[@"message"] isEqualToString:@"OK"]) {
            NSDictionary *dic = responseObject[@"data"];
            NSDictionary *away_team_players = dic[@"away_team_players"];
            
            NSDictionary *home_team_players = dic[@"home_team_players"];
            
            //NSLog(@"%@",home_team_players[@"formation"]);
            if ([away_team_players[@"formation"] isKindOfClass:[NSString class]]) {
                _awayFormatiom = away_team_players[@"formation"];
            }else{
                _awayFormatiom = @"";
            }
            _awayMap = away_team_players[@"lineup"][@"map"];
            
            if ([home_team_players[@"formation"] isKindOfClass:[NSString class]]) {
                _homeFormation = home_team_players[@"formation"];
            }else{
                _homeFormation = @"";
            }
            _awayMap = home_team_players[@"lineup"][@"map"];
            
            NSDictionary *homelineup = home_team_players[@"lineup"];
            NSDictionary *awaylineup = away_team_players[@"lineup"];
            NSArray *awayPlayers = awaylineup[@"players"];
            
            NSArray *homePlayers = homelineup[@"players"];
            
            NSMutableArray *mArray1 = [NSMutableArray array];
            NSMutableArray *mArray2 = [NSMutableArray array];
            
            //敌方
            for (NSDictionary *dic in awayPlayers) {
                PlayerModel *awayPlayerModel = [PlayerModel yy_modelWithDictionary:dic];
                [mArray1 addObject:awayPlayerModel];
            }
            _awayPlayerModels = [mArray1 copy];
            //我方
            for (NSDictionary *dic in homePlayers) {
                PlayerModel *homePlayerModel = [PlayerModel yy_modelWithDictionary:dic];
                [mArray2 addObject:homePlayerModel];
            }
            _homePlayerModels = [mArray2 copy];
            UITableView *tableView = (UITableView *)[_scrollView viewWithTag:200];
            [tableView reloadData];
        }else{
            NSLog(@"暂无数据");
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed");
    }];
}
-(void)createMainView{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"video_return@2x"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"比赛详情";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    
    self.navigationItem.titleView = label;
    
    //比赛状况视图
    _detailView = (DetailView *)[[NSBundle mainBundle]loadNibNamed:@"DetailView" owner:nil options:nil].lastObject;
    _detailView.frame = CGRectMake(0, 64, kScreenWidth, 80);
    _detailView.model = self.model;
    _detailView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self.view addSubview:_detailView];
    
    [self createTopView];
    [self createBottomScrollView];
    
}
-(void)createTopView{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, _detailView.bottom, kScreenWidth, 30)];
    [self.view addSubview:_topView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_topView addSubview:leftBtn];
    [_topView addSubview:rightBtn];
    
    leftBtn.frame = CGRectMake(0, 0, _topView.width/2, _topView.height);
    //leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:@"阵容" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftBtn.selected = YES;
    leftBtn.tag = 100;
    
    rightBtn.frame = CGRectMake(leftBtn.right, 0, _topView.width/2, _topView.height);
    //rightBtn.backgroundColor = [UIColor greenColor];
    [rightBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"历史" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.tag = 101;
                      
    
}
-(void)btnAction : (UIButton *)btn{
    UIButton *b1 = (UIButton *)[_topView viewWithTag:100];
    UIButton *b2 = (UIButton *)[_topView viewWithTag:101];
    b1.selected = NO;;
    b2.selected = NO;
    btn.selected = YES;
    if (btn.tag == 100) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }else{
        [_scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
    }
    
}

-(void)createBottomScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _topView.bottom, kScreenWidth, kScreenHeight - 64 - _detailView.height - _topView.height)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    UITableView *leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _scrollView.height) style:UITableViewStyleGrouped];
   
    leftTableView.backgroundColor = [UIColor whiteColor];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.tag = 200;
    [leftTableView registerNib:[UINib nibWithNibName:@"LineupTableViewCell" bundle:nil] forCellReuseIdentifier:@"LineupCell"];
    [_scrollView addSubview:leftTableView];
    
    
    UITableView *rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, _scrollView.height) style:UITableViewStyleGrouped];
    rightTableView.backgroundColor = [UIColor whiteColor];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.tag = 201;
    [rightTableView registerNib:[UINib nibWithNibName:@"HistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"HistoryCell"];
    [_scrollView addSubview:rightTableView];
}
#pragma _ mark scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) {
        CGPoint point = scrollView.contentOffset;
        NSInteger pageNum =(NSInteger)(point.x / kScreenWidth) + 1;
        
        UIButton *b1 = (UIButton *)[_topView viewWithTag:100];
        UIButton *b2 = (UIButton *)[_topView viewWithTag:101];
        b1.selected = NO;
        b2.selected = NO;
        
        if (pageNum == 1) {
            b1.selected = YES;
        }else{
            b2.selected = YES;
        }
    }
}
#pragma - mark tableViewDelegate,DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 200) {
        return 2;
    }else{

        return _dataArray.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 200) {
        //lineup
        if (section == 0) {
            return _awayPlayerModels.count;
        }else if(section == 1){
            return _homePlayerModels.count;
        }else{
            return 0;
        }
    }else{
        //history
        NSArray *array = [_dataArray[section] copy];

        return array.count;
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    UITableView *tabView = (UITableView *)[_scrollView viewWithTag:200];
    if (tableView == tabView) {
        return 300;
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 201) {
        return nil;
    }
    LineupHeaderView *view = (LineupHeaderView *)[[NSBundle mainBundle]loadNibNamed:@"LineupHeaderView" owner:nil options:nil].lastObject;
    view.teamName = _model.atname;

    if (section == 0) {
        view.teamName = _model.atname;
        view.formatter = _awayFormatiom;
        view.mapArray = _awayMap;
    }else{
        view.teamName = _model.htname;
        view.formatter = _homeFormation;
        view.mapArray = _homeMap;
    }
    
    if (_awayFormatiom.length == 0) {
        view.isHide = YES;
    }else{
        view.isHide = NO;
    }
    
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 200) {
        //左边TableView
        LineupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LineupCell"];
        if (indexPath.section == 0) {
            cell.model = _awayPlayerModels[indexPath.row];
        }else if (indexPath.section == 2){
            cell.model = _homePlayerModels[indexPath.row];
        }
        return cell;
    }else{
        //右边TableView
        HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell"];
        NSDictionary *dic = _dataArray[indexPath.section][indexPath.row];
        HistoryMoedl *model = [HistoryMoedl yy_modelWithDictionary:dic];
        cell.model  = model;
        return cell;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *atname = self.model.atname;
    NSString *htname = self.model.htname;
    NSString *title;
    switch (section) {
        case 0:
            title = @"两队交锋";
            break;
          
        case 1:
            title = [NSString stringWithFormat:@"%@近期比赛",atname];
            break;
            
        case 2:
            title = [NSString stringWithFormat:@"%@近期比赛",htname];
            break;
            
        default:
            break;
    }
    if (tableView.tag == 201) {
        return title;
    }else{
        return nil;
    }
    
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
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
