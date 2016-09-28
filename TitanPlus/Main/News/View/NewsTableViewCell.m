//
//  NewsTableViewCell.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/17.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell
-(void)setTime:(NSString *)time{
    _time = time;
//    self.timeLabel.text = _time;
//    self.timeLabel.font = [UIFont systemFontOfSize:14];
//    self.timeLabel.textColor = [UIColor lightGrayColor];
}
-(void)setModel:(NewsModel *)model{
    _model = model;
    
    self.timeLabel.text = model.time;
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
    
    
    [self.authorIcon sd_setImageWithURL:[NSURL URLWithString:model.authorHeadImage]];
    self.authorIcon.layer.cornerRadius = 20;
    self.authorIcon.clipsToBounds = YES;
    [self.contentView bringSubviewToFront:self.authorIcon];
    
    self.autherName.text = model.authorName;
    self.autherName.font = [UIFont systemFontOfSize:14];
    self.autherName.textColor = [UIColor lightGrayColor];
    
    
    NSDictionary *atteibutes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    
    CGRect rect = [model.title boundingRectWithSize:CGSizeMake(kScreenWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:atteibutes context:nil];
    
    self.titleLabel.text = model.title;
    self.titleLabel.frame = CGRectMake(5, _timeLabel.bottom, kScreenWidth - 10, rect.size.height);
    
    _cellHeight = 161 + rect.size.height ;
}
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:_titleLabel];
    }
    
    
    return _titleLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
