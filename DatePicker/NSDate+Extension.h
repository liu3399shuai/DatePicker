//
//  NSDate+Extension.h
//
//  Created by liu on 15/9/21.
//  Copyright (c) 2015年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDate (Extension)

-(NSString *)dateString;
-(NSString *)dateString2;

-(NSString *)ymString;

-(NSString *)mdString;
-(NSString *)mdString2;

-(NSString *)fullString;


/**
 *  获取当前日期是周几
 *
 *  @return 输出结果是星期几的字符串。
 */
-(NSString *)weekday;

-(NSString *)weekdayString;

/**
 *  获取当前日期所在月的第一天是周几
 *
 *  @return 输出结果是星期几的字符串。
 */
-(NSString *)firstWeekdayInCurrentMonth;

/**
 *  获取当前日期所在月有多少天
 *
 *  @return 天数
 */
-(NSInteger)daysInCurrentMonth;

/**
 *  获取当前日期所在月的下offset个月
 *
 *  @return 获得时间
 */
-(NSDate *)dateOffsetMonth:(NSInteger)offset;

/**
 *  获取当前日期的下offset个日期
 *
 *  @return 获得时间
 */
-(NSDate *)dateOffsetDay:(NSInteger)offset;
/**
 *  获取当前日期组件实例
 *
 *  @return 获得组件实例
 */
-(NSDateComponents *)components;

+(NSDate *)dateFromSelectIndex:(NSIndexPath *)indexPath;

-(NSIndexPath *)indexPath;

@end
