//
//  DetailView.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/21.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "DetailView.h"

//    @property(nonatomic,copy)NSString *atscore;
//    @property(nonatomic,copy)NSString *atname;
//    @property(nonatomic,copy)NSString *htscore;
//    @property(nonatomic,copy)NSString *htname;
//    @property(nonatomic,copy)NSString *atlogo;
//    @property(nonatomic,copy)NSString *htlogo;
//    @property(nonatomic,copy)NSString *tourname;
//    @property(nonatomic,copy)NSString *mtime;
//    @property(nonatomic,copy)NSString *eid;
@implementation DetailView

-(void)setModel:(MatchModel *)model{
    _model = model;
    NSString *htUrlStr = [NSString stringWithFormat:@"http://static-cdn.ballq.cn/%@",_model.htlogo];
    NSString *atUrlStr = [NSString stringWithFormat:@"http://static-cdn.ballq.cn/%@",_model.atlogo];
    [_leftImgView sd_setImageWithURL:[NSURL URLWithString:htUrlStr]];
    [_rightImgView sd_setImageWithURL:[NSURL URLWithString:atUrlStr]];
    _leftLabel.text = _model.htname;
    _rightLabel.text = _model.atname;
    
    if (_model.atscore.length != 0 && _model.htscore.length != 0) {
        //NSLog(@"%ld",_model.atscore.length);

        _centerLabel.text = [NSString stringWithFormat:@"%@ - %@",_model.htscore,_model.atscore];
        _bottomLabel.text = @"正在比赛";
    }else{
        NSString *timeStr = _model.mtime;
        NSArray *array1 = [timeStr componentsSeparatedByString:@"T"];
        NSString *subStr = array1[1];
        
        NSArray *array2 = [subStr componentsSeparatedByString:@":"];
        
        NSString *str1 = array2[0];
        NSString *str2 = array2[1];
        
        NSString *time = [NSString stringWithFormat:@"%@:%@",str1,str2];
        _centerLabel.text = time;
        _bottomLabel.text = nil;
    }
    
    _topLabel.text = _model.tourname;
    
}
-(void)awakeFromNib{
    _view1.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    _view2.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    _leftImgView.layer.cornerRadius = 12.5;
    _leftImgView.layer.masksToBounds = YES;
    _rightImgView.layer.cornerRadius = 12.5;
    _rightImgView.layer.masksToBounds = YES;
}

@end
