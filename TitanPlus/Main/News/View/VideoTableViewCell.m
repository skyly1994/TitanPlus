//
//  VideoTableViewCell.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/19.
//  Copyright © 2016年 陆斌. All rights reserved.
//

/*
 @property(nonatomic,assign)NSInteger clientuser_id;
 @property(nonatomic,assign)CGFloat duration;
 @property(nonatomic,strong)NSURL *htmlurl;
 @property(nonatomic,strong)NSURL *icon;
 @property(nonatomic,copy)NSString *nickname;
 @property(nonatomic,copy)NSString *source;
 @property(nonatomic,strong)NSURL *thumbnail;
 @property(nonatomic,copy)NSString *title;
 @property(nonatomic,strong)NSURL *videourl;
 */
#import "VideoTableViewCell.h"

@implementation VideoTableViewCell
-(void)setModel:(VideoModel *)model{
    _model = model;
    
    self.TitleLabel.text = model.title;
    self.NickName.text = model.nickname;
    [self.IconImgView sd_setImageWithURL:model.icon];
    [self.VideoImgView sd_setImageWithURL:model.thumbnail];
    self.videoUrl = model.videourl;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.TitleLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"videotitlebottom@3x"]];
    [self.contentView bringSubviewToFront:_PlayBtn];
    [self.contentView bringSubviewToFront:_TitleLabel];
    self.IconImgView.layer.cornerRadius = 15;
    self.IconImgView.layer.masksToBounds = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
