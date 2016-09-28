//
//  ChannelTableViewCell.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/23.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelModel.h"
@interface ChannelTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *shortTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property(nonatomic,strong)ChannelModel *model;
@end
