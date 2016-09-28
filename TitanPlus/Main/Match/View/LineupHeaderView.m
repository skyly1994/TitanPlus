//
//  LineupHeaderView.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/22.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "LineupHeaderView.h"

@implementation LineupHeaderView

-(void)setFormatter:(NSString *)formatter{
    _formatter = formatter;
    if (formatter == nil) {
        _topLabel.text = @"暂无数据";
    }else{
    _topLabel.text = [NSString stringWithFormat:@"%@阵型:%@",_teamName,_formatter];
    }
}
-(void)setMapArray:(NSArray *)mapArray{
    _mapArray = mapArray;
    
}
-(void)setIsHide:(BOOL)isHide{
    _isHide = isHide;
    if (_formatter.length != 0) {
        
        NSArray * array = [_formatter componentsSeparatedByString:@"-"];
        NSInteger firstLineCount = [array[2] integerValue];
        NSInteger secondLineCount = [array[1] integerValue];
        NSInteger thirdLineCount = [array[0] integerValue];
        
        
        
        
        for (int i = 0; i < 13; i++) {
            UIButton *button = (UIButton *)[_centerImgView viewWithTag:i +100];
            //button.hidden = isHide;
            [self lineupWithLineCount:firstLineCount button:button index:i lineNum:0 isHiden:_isHide];
            [self lineupWithLineCount:secondLineCount button:button index:i lineNum:1 isHiden:_isHide];
            [self lineupWithLineCount:thirdLineCount button:button index:i lineNum:2 isHiden:_isHide];
            if (i == 12 && _formatter.length != 0) {
                button.hidden = _isHide;
            }
            
            
            
        }
    }
    
}
-(void)lineupWithLineCount:(NSInteger)linecount
                    button:(UIButton *)button
                     index:(NSInteger)i
                  lineNum :(NSInteger)n
                  isHiden : (BOOL)ishiden{
    const NSInteger Num = n * 4;
    
    switch (linecount) {
        case 0:
            break;
        case 1:
            if (i == 0 + Num) {
                button.hidden = ishiden;
            }else if (i == 1 + Num){
                
            }else if (i == 2 + Num){
            
            }else if (i == 3 + Num){
            
            }
            
            break;
        case 2:
            if (i == 0 + Num) {
                
            }else if (i == 1 + Num){
                button.hidden = ishiden;
            }else if (i == 2 + Num){
                button.hidden = ishiden;
            }else if (i == 3 + Num){
                
            }

            break;
        case 3:
            if (i == 0 + Num) {
                button.hidden = ishiden;
            }else if (i == 1 + Num){
                button.hidden = ishiden;
            }else if (i == 2 + Num){
                button.hidden = ishiden;
            }else if (i == 3 + Num){
                
            }
            
            break;
        case 4:
            if (i == 0 + Num) {
                button.hidden = ishiden;
            }else if (i == 1 + Num){
                button.hidden = ishiden;
            }else if (i == 2 + Num){
                button.hidden = ishiden;
            }else if (i == 3 + Num){
                button.hidden = ishiden;
            }

            break;

        default:
            if (i == 0 + Num) {
                button.hidden = ishiden;
            }else if (i == 1 + Num){
                button.hidden = ishiden;
            }else if (i == 2 + Num){
                button.hidden = ishiden;
            }else if (i == 3 + Num){
                button.hidden = ishiden;
            }
            break;
    }
    
}
-(void)awakeFromNib{
    
    CGFloat btnWidth = (self.centerImgView.width - 30) / 4 - 30;
    CGFloat space = 30;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 4; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"tag_jersey_1@2x"] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor clearColor];
            button.frame = CGRectMake(j *(btnWidth + space) + 30, i * (btnWidth + 10) + 20, btnWidth, btnWidth);
            button.tag = i * 4 + j + 100;
            button.hidden = YES;
            [self.centerImgView addSubview:button];
        }
    }
    
    UIButton *doorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doorBtn setBackgroundImage:[UIImage imageNamed:@"tag_jersey_2@2x"] forState:UIControlStateNormal];
    doorBtn.backgroundColor = [UIColor clearColor];
    doorBtn.frame = CGRectMake(self.centerImgView.width / 2 -20, self.centerImgView.height - btnWidth -20, btnWidth, btnWidth);
    doorBtn.tag = 12 + 100;
    doorBtn.hidden = YES;
    [self.centerImgView addSubview:doorBtn];
    
    
}

@end
