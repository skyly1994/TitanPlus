//
//  VideoTableViewCell.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/19.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
@class VideoModel;
@interface VideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *VideoImgView;
@property (weak, nonatomic) IBOutlet UIButton *PlayBtn;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *IconImgView;
@property (weak, nonatomic) IBOutlet UILabel *NickName;
@property (weak, nonatomic) IBOutlet UILabel *MessageNum;
@property (weak, nonatomic) IBOutlet UIImageView *MessageImgView;

@property(nonatomic,strong)NSURL *videoUrl;
@property(nonatomic,strong)VideoModel *model;
@end
