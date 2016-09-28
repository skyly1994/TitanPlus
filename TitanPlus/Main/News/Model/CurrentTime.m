//
//  CurrentTime.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/17.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "CurrentTime.h"

@implementation CurrentTime
-(instancetype)init{
    self = [super init];
    if (self) {
        NSDate *date = [NSDate date];//这个是NSDate类型的日期，所要获取的年月日都放在这里；
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|
        NSCalendarUnitDay;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
        
        NSDateComponents *d = [cal components:unitFlags fromDate:date];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
        //然后就可以从d中获取具体的年月日了；
        _year = [d year];
        _month = [d month];
        _day  =  [d day];
    }
    return self;
}

@end
