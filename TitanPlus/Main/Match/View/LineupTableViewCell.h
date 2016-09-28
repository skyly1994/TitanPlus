//
//  LineupTableViewCell.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/21.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerModel.h"
@interface LineupTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionlabel;
@property (weak, nonatomic) IBOutlet UILabel *ground;
@property (weak, nonatomic) IBOutlet UILabel *first;
@property (weak, nonatomic) IBOutlet UILabel *inBall;

@property(nonatomic,strong)PlayerModel *model;

@end
