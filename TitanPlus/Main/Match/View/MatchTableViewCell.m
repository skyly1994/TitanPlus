//
//  MatchTableViewCell.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/20.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "MatchTableViewCell.h"
/*
 @property(nonatomic,copy)NSString *atscore;
 @property(nonatomic,copy)NSString *atname;
 @property(nonatomic,copy)NSString *htscore;
 @property(nonatomic,copy)NSString *htname;
 @property(nonatomic,strong)NSURL *atlogo;
 @property(nonatomic,strong)NSURL *htlogo;
 @property(nonatomic,copy)NSString *tourname;
 @property(nonatomic,copy)NSString *mtime;
 */

//http://static-cdn.ballq.cn/teams/1cc4bdf0-8910-47d7-855b-235983d7b8ce.gif
//htUrlStr	__NSCFString *	@"http://static-cdn.ballq.cn/teams/teams/9990d99a-641c-414e-87d2-e6a2a652e589.jpg"	0x00007fa048e22170

//2016-09-20T19:00:00Z
//NSArray *array1 = [_weibo.source componentsSeparatedByString:@">"];
//        NSString *subString = [array1 objectAtIndex:1];
//        NSArray *array2 = [subString componentsSeparatedByString:@"<"];
//        NSString *source = array2.firstObject;
@implementation MatchTableViewCell
-(void)setModel:(MatchModel *)model{
    _model = model;
    
    NSString *timeStr = _model.mtime;
    NSArray *array1 = [timeStr componentsSeparatedByString:@"T"];
    NSString *subStr = array1[1];
    
    NSArray *array2 = [subStr componentsSeparatedByString:@":"];
    
    NSString *str1 = array2[0];
    NSString *str2 = array2[1];
    
    NSString *time = [NSString stringWithFormat:@"%@:%@",str1,str2];
    _timeLabel.text = time;
    
    
    NSString *htUrlStr = [NSString stringWithFormat:@"http://static-cdn.ballq.cn/%@",_model.htlogo];
    NSString *atUrlStr = [NSString stringWithFormat:@"http://static-cdn.ballq.cn/%@",_model.atlogo];
    

    [self.htLogo sd_setImageWithURL:[NSURL URLWithString:htUrlStr] placeholderImage:[UIImage imageNamed:@"default"]];
    [self.atLogo sd_setImageWithURL:[NSURL URLWithString:atUrlStr] placeholderImage:[UIImage imageNamed:@"default"]];
    self.htNameLabel.text = _model.htname;
    self.atNameLabel.text = _model.atname;
    self.htScoreLabel.text = _model.htscore;
    self.atScoreLabel.text = _model.atscore;
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
