//
//  ChannelTableViewCell.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/23.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "ChannelTableViewCell.h"

@implementation ChannelTableViewCell
-(void)setModel:(ChannelModel *)model{
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.imgurl]];
    _shortTitleLabel.text = _model.shorttitle;
    _titlelabel.text = _model.title;
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
