//
//  PlayerModel.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/22.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 id = 98048;
 name = "\U74e6\U4f26\U897f\U5947, \U83f2\U5229\U666e";
 nationality = SVN;
 "nationality_url" = "http://ballq.oss-cn-beijing.aliyuncs.com/countries/56b4c616-4f4a-4f74-9828-697841de8b12.png";
 "pos_GMDF" = F;
 position = 8;
 "shirt_number" = 4;
 status =                         {
 "goals_in_tournamet" = "";
 "matches_played_in_tournament" = "";
 "start_xi" = "";
 };
 substitute = 0;
 }
 */
@interface PlayerModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *shirt_number;
@property(nonatomic,strong)NSDictionary *status;
@end
