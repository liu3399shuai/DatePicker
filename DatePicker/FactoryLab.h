//
//  FactoryLab.h
//  liu
//
//  Created by liu on 16/1/18.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FactoryLab : UILabel

+(instancetype)tip:(NSString *)text;

+(instancetype)strong:(NSString *)text;

+(instancetype)lab:(NSString *)text color:(UIColor *)color font:(UIFont *)font;

@end
