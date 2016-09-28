//
//  MatchTableViewCell.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/20.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchModel.h"
@class MatchModel;
@interface MatchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *atLogo;
@property (weak, nonatomic) IBOutlet UILabel *atNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *atScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *htLogo;
@property (weak, nonatomic) IBOutlet UILabel *htNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *htScoreLabel;

@property(nonatomic,copy)MatchModel *model;

@end
