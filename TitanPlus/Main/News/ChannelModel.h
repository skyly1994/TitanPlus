//
//  ChannelModel.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/23.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelModel : NSObject

@property(nonatomic,copy)NSString *imgurl;//图片url
@property(nonatomic,copy)NSString *shareurl;//新闻链接
@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,copy)NSString *authorName;//作者名字
@property(nonatomic,copy)NSString *shorttitle;

@property(nonatomic,copy)NSString *time;
@end
