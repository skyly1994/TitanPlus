//
//  LineupHeaderView.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/22.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchModel.h"
@interface LineupHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIImageView *centerImgView;


@property(nonatomic,copy)NSString *formatter;
@property(nonatomic,strong)NSArray *mapArray;
@property(nonatomic,copy)NSString *teamName;

@property(nonatomic,assign)BOOL isHide;
@end
