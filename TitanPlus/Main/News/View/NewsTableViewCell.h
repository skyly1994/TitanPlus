//
//  NewsTableViewCell.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/17.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *autherName;
@property (weak, nonatomic) IBOutlet UIImageView *authorIcon;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)NewsModel *model;
@property(nonatomic,assign)NSInteger cellHeight;
@end
