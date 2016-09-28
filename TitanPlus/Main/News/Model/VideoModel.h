//
//  VideoModel.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/19.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property(nonatomic,assign)NSInteger clientuser_id;
@property(nonatomic,assign)CGFloat duration;
@property(nonatomic,strong)NSURL *htmlurl;
@property(nonatomic,strong)NSURL *icon;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,strong)NSURL *thumbnail;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSURL *videourl;
@end
