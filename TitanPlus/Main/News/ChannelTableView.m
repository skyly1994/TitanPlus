//
//  ChannelTableView.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/23.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "ChannelTableView.h"
#import "AFNetworking.h"
#import "ChannelModel.h"
#import "YYModel.h"
#import "ChannelTableViewCell.h"
#import "ChannelWebViewController.h"
@class ChannelModel;
@class AFHTTPSessionManager;
@class ChannelTableViewCell;
@implementation ChannelTableView
{
    NSMutableArray *_modelArray;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style   {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = 80;
        [self registerNib:[UINib nibWithNibName:@"ChannelTableViewCell" bundle:nil] forCellReuseIdentifier:@"channelCell"];
        
        __weak ChannelTableView *wSelf = self;
        [self addInfiniteScrollingWithActionHandler:^{
            __strong ChannelTableView *strongSelf = wSelf;
            [strongSelf loadMoredata];
        }];
    }
    return self;
}
-(void)loadMoredata{
    _sctionid--;
    NSString *sctionidStr = [NSString stringWithFormat:@"%ld",_sctionid];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://www1.ttplus.cn/publish/app/list//%@/%@.json",_sctionpath,sctionidStr];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"%@",responseObject);
        //NSLog(@"success %@ %@",_sctionpath,sctionidStr);
        NSArray *array = responseObject[@"datas"];
        
        for (NSDictionary *dic in array) {
            ChannelModel *model = [ChannelModel yy_modelWithDictionary:dic];
            [_modelArray addObject:model];
        }
        
        [self reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed %@ %@",_sctionpath,sctionidStr);
    }];
    
    [self.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];

}
-(void)loadDataWithSctionpath : (NSString *)sctionpath
                     sctionid : (NSString *)sctionid{
    
    _sctionid = [sctionid integerValue];
    _sctionpath = sctionpath;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://www1.ttplus.cn/publish/app/list//%@/%@.json",sctionpath,sctionid];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"%@",responseObject);
        NSArray *array = responseObject[@"datas"];
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            ChannelModel *model = [ChannelModel yy_modelWithDictionary:dic];
            [mArray addObject:model];
        }
        _modelArray = [mArray mutableCopy];
        [self reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed %@ %@",sctionpath,sctionid);
    }];
}


#pragma - mark scrollviewDelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

//}

#pragma - mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChannelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"channelCell"];
    cell.model = _modelArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChannelModel *model = _modelArray[indexPath.row];
    NSString *url = model.shareurl;
    ChannelWebViewController *webCtrl = [[ChannelWebViewController alloc]init];
    webCtrl.url = url;
    
    UIResponder *nextResponder = self;
    while (![nextResponder isKindOfClass:[UIViewController class]]) {
        nextResponder = nextResponder.nextResponder;
    }
    UIViewController *VC = (UIViewController *)nextResponder;
    NSLog(@"%@",VC);
    //VC.hidesBottomBarWhenPushed = YES;
    
    [VC.navigationController pushViewController:webCtrl animated:YES];
    
    
    
}
#pragma - mark UITableViewDelegate

@end
