//
//  DiscoverModel.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/24.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 icon = "http://resource.ttplus.cn/product/leshitiyu.png";
 id = 1;
 name = "12\U5f3a\U8d5b";
 url = "http://12.lesports.com/?ch=zchaottzl";
 }
 */
@interface DiscoverModel : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *url;
@end
