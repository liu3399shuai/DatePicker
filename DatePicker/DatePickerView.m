//
//  DatePickerView.m
//  liu
//
//  Created by liu on 16/4/20.
//  Copyright © 2016年 liu. All rights reserved.
//

#define Font(x)                         [UIFont systemFontOfSize : x]


#import "DatePickerView.h"
#import "NSDate+Extension.h"

@implementation DatePickerView

@end

@implementation DatePickerCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.numLab.textAlignment = 1;
        self.numLab.bounds = CGRectMake(0, 0, 30, 30);
        self.numLab.center = CGPointMake(frame.size.width/2.f, frame.size.height/2.f-10);
        self.numLab.layer.masksToBounds = YES;
        self.numLab.layer.cornerRadius = 15;
        
        self.tipLab.textAlignment = 1;
        self.tipLab.bounds = CGRectMake(0, 0, 30, 30);
        self.tipLab.center = CGPointMake(frame.size.width/2.f, frame.size.height/2.f+15);
        
        [self addSubview:self.numLab];
        [self addSubview:self.tipLab];
        
    }
    
    return self;
}

-(FactoryLab *)numLab
{
    if (_numLab == nil) {
        _numLab = [FactoryLab lab:@"" color:[UIColor blueColor] font:Font(15)];
    }
    
    return _numLab;
}

-(FactoryLab *)tipLab
{
    if (_tipLab == nil) {
        _tipLab = [FactoryLab lab:@"" color:[UIColor grayColor] font:Font(12)];
    }
    
    return _tipLab;
}

-(void)updateCellIndex:(NSIndexPath *)indexPath select:(BOOL)select
{
    NSDate *date = [[NSDate date] dateOffsetMonth:indexPath.section];
    
    NSInteger day = indexPath.row - [date firstWeekdayInCurrentMonth].integerValue + 1;
    
    _numLab.text = (day <= 0) ? @"" : [NSString stringWithFormat:@"%ld",(long)day];
    
    NSInteger status = 0; // 0 小于today  1 等于today  2 大于today
    if (date.components.month == [NSDate date].components.month) {
        if (day > [NSDate date].components.day) {
            status = 2;
        }else if (day == [NSDate date].components.day){
            status = 1;
        }else{
            status = 0;
        }
    }else{ // 两种情况 当前month=5，下个month=6 ； 当前month=12，下个month=1
        status = 2;
    }
    
    UIColor *color = nil;
    if (status == 0) {
        color = [UIColor grayColor];
    }else if (status == 1){
        color = [UIColor grayColor];
    }else if (status == 2){
        color = [UIColor blueColor];
    }
    
    if (select) {
        color = [UIColor whiteColor];
    }
    
    _numLab.textColor = color;
    
    _tipLab.text = (status == 1) ? @"今天" : @"";
    
    self.userInteractionEnabled = (status == 2) ? YES : NO;
    
    _numLab.backgroundColor = (select) ? [UIColor redColor] : [UIColor clearColor];
}

@end

@implementation DatePickerHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.tipLab.textAlignment = 1;
        self.tipLab.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
        self.tipLab.center = CGPointMake(frame.size.width/2.f, frame.size.height/2.f);
        
        [self addSubview:self.tipLab];
    }
    
    return self;
}

-(FactoryLab *)tipLab
{
    if (_tipLab == nil) {
        _tipLab = [FactoryLab lab:@"" color:[UIColor blackColor] font:Font(14)];
    }
    
    return _tipLab;
}

@end

@implementation DatePickerFooterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor grayColor];
    }
    
    return self;
}

@end
