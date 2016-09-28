//
//  HistoryTableViewCell.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/21.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryMoedl.h"
@interface HistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property(nonatomic,strong)HistoryMoedl *model;
@end
