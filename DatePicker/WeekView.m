//
//  WeekView.m
//  liu
//
//  Created by liu on 16/4/19.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "WeekView.h"

@interface WeekView()

@property (nonatomic,strong) NSArray *weeks;

@end

@implementation WeekView

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        _weeks = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        
        for (int i = 0; i < _weeks.count; i++) {
            FactoryLab *lab = [FactoryLab lab:_weeks[i] color:[UIColor whiteColor] font:[UIFont systemFontOfSize:12]];
            lab.textAlignment = 1;
            lab.tag = 10+i;
            [self addSubview:lab];
        }
    }
    
    return self;
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    UIView *previous = self;
    
    for (int i = 0; i < _weeks.count; i++) {
        UIView *view = [self viewWithTag:10+i];
        
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo((i == 0) ? previous : previous.mas_right);
            make.centerY.equalTo(self);
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width/7.f));
        }];
        
        previous = view;
    }
}

@end
