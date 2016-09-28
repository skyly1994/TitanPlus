//
//  HistoryMoedl.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/21.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryMoedl : NSObject
@property(nonatomic,copy)NSString *away_team;
@property(nonatomic,copy)NSString *away_team_logo;
@property(nonatomic,copy)NSString *away_team_score;
@property(nonatomic,copy)NSString *home_team;
@property(nonatomic,copy)NSString *home_team_logo;
@property(nonatomic,copy)NSString *home_team_score;
@property(nonatomic,copy)NSString *match_time;
@property(nonatomic,copy)NSString *tournament;
@property(nonatomic,copy)NSString *team_result;
@end
