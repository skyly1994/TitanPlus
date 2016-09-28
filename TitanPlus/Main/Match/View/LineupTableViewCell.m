//
//  LineupTableViewCell.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/21.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "LineupTableViewCell.h"
/*
 @property(nonatomic,copy)NSString *name;
 @property(nonatomic,copy)NSString *shirt_number;
 @property(nonatomic,strong)NSDictionary *status;
 
 status =                     {
 "goals_in_tournamet" = "";
 "matches_played_in_tournament" = "";
 "start_xi" = "";
 };
*/
@implementation LineupTableViewCell
-(void)setModel:(PlayerModel *)model{
    _model = model;
    _nameLabel.text = _model.name;
    _numLabel.text = _model.shirt_number;
    
    NSNumber *n1 = _model.status[@"goals_in_tournamet"];
    NSNumber *n2 = _model.status[@"matches_played_in_tournament"];
    NSNumber *n3 = _model.status[@"start_xi"];
    
    NSInteger x1 = [n1 integerValue];
    NSInteger x2 = [n2 integerValue];
    NSInteger x3 = [n3 integerValue];
    
    _ground.text = [NSString stringWithFormat:@"%ld",x2];
    _first.text = [NSString stringWithFormat:@"%ld",x3];
    _inBall.text = [NSString stringWithFormat:@"%ld",x1];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
