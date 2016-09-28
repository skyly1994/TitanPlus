//
//  WebViewController.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/17.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property(nonatomic,strong)NSURL *url;
-(instancetype)initWithUrl : (NSString *)urlStr;
@end
