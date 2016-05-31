//
//  FactoryLab.m
//  liu
//
//  Created by liu on 16/1/18.
//  Copyright © 2016年 liu. All rights reserved.
//

#define Font(x)                         [UIFont systemFontOfSize : x]

#import "FactoryLab.h"

@implementation FactoryLab

+(instancetype)lab:(NSString *)text color:(UIColor *)color font:(UIFont *)font
{
    FactoryLab *lab = [[FactoryLab alloc] init];
    lab.font = font ? : Font(15);
    lab.textColor = color ? : [UIColor blackColor];
    lab.text = text;
    lab.backgroundColor = [UIColor clearColor];
    lab.numberOfLines = 10;
    
    return lab;
}

+(instancetype)tip:(NSString *)text
{
    return [FactoryLab lab:text color:[UIColor grayColor] font:Font(13)];
}

+(instancetype)strong:(NSString *)text
{
    return [FactoryLab lab:text color:[UIColor blackColor] font:Font(15)];
}

@end
