//
//  ChannelTableView.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/23.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelTableView : UITableView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *sctionpath;
@property(nonatomic,assign)NSInteger sctionid;




-(void)loadDataWithSctionpath : (NSString *)sctionpath
                     sctionid : (NSString *)sctionid;



@end
