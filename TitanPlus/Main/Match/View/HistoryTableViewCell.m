//
//  HistoryTableViewCell.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/21.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "HistoryTableViewCell.h"
/*
 @property(nonatomic,copy)NSString *away_team;
 @property(nonatomic,copy)NSString *away_team_logo;
 @property(nonatomic,copy)NSString *away_team_score;
 @property(nonatomic,copy)NSString *home_team;
 @property(nonatomic,copy)NSString *home_team_logo;
 @property(nonatomic,copy)NSString *home_team_score;
 @property(nonatomic,copy)NSString *match_time;
 @property(nonatomic,copy)NSString *tournament;
 @property(nonatomic,copy)NSString *team_result;
 */
//2016-08-20T19:15:00Z
@implementation HistoryTableViewCell
-(void)setModel:(HistoryMoedl *)model{
    _model = model;
    NSString *timeStr = _model.match_time;
    NSArray *array = [timeStr componentsSeparatedByString:@"-"];
    NSString *subStr= array[2];
    NSArray *array2 = [subStr componentsSeparatedByString:@"T"];
    _timeLabel.text = [NSString stringWithFormat:@"%@/%@",array[1],array2[0]];
    
    _leftLabel.text = _model.away_team;
    _rightLabel.text = _model.home_team;
    
    _scoreLabel.text = [NSString stringWithFormat:@"%@ : %@",_model.away_team_score,_model.home_team_score];
    

    NSInteger awayScore = [_model.away_team_score integerValue];
    NSInteger homeScore = [_model.home_team_score integerValue];
    if (awayScore > homeScore) {
        _resultLabel.text = @"负";
        _resultLabel.backgroundColor = [UIColor redColor];
    }else if (awayScore < homeScore){
        _resultLabel.text = @"胜";
        _resultLabel.backgroundColor = [UIColor greenColor];
    }else{
        _resultLabel.text = @"平";
        _resultLabel.backgroundColor = [UIColor grayColor];
    }
    

    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _resultLabel.layer.cornerRadius = 5;
    _resultLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
