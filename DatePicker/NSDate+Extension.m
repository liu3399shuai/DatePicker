//
//  NSDate+Extension.m
//  liu
//
//  Created by liu on 15/9/21.
//  Copyright (c) 2015年 liu. All rights reserved.
//

#import "NSDate+Extension.h"

static NSDateFormatter *dateYMDFormatter;
static NSDateFormatter *dateYMDFormatter2;
static NSDateFormatter *dateYMFormatter;
static NSDateFormatter *dateMDFormatter;
static NSDateFormatter *dateMDFormatter2;
static NSDateFormatter *dateFullFormatter;

static NSCalendar      *calendar;

@implementation NSDate (Extension)

+ (void)load
{
    dateYMDFormatter = [[NSDateFormatter alloc] init];
    dateYMDFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMDFormatter setDateFormat:@"yyyy-MM-dd"];
    
    dateYMDFormatter2 = [[NSDateFormatter alloc] init];
    dateYMDFormatter2.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMDFormatter2 setDateFormat:@"yyyy年MM月dd日"];
    
    dateYMFormatter = [[NSDateFormatter alloc] init];
    dateYMFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMFormatter setDateFormat:@"yyyy年MM月"];
    
    dateMDFormatter = [[NSDateFormatter alloc] init];
    dateMDFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateMDFormatter setDateFormat:@"MM-dd"];
    
    dateMDFormatter2 = [[NSDateFormatter alloc] init];
    dateMDFormatter2.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateMDFormatter2 setDateFormat:@"MM月dd日"];
    
    dateFullFormatter = [[NSDateFormatter alloc] init];
    dateFullFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFullFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
}

-(NSString *)dateString
{
    return [dateYMDFormatter stringFromDate:self];
}

-(NSString *)dateString2
{
    return [dateYMDFormatter2 stringFromDate:self];
}

-(NSString *)ymString
{
    return [dateYMFormatter stringFromDate:self];
}

-(NSString *)mdString
{
    return [dateMDFormatter stringFromDate:self];
}

-(NSString *)mdString2
{
    return [dateMDFormatter2 stringFromDate:self];
}

-(NSString *)fullString;
{
    return [dateFullFormatter stringFromDate:self];
}


-(NSString *)weekday
{
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:self];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
    
    return [weekdays objectAtIndex:comps.weekday];
}

-(NSString *)weekdayString
{
    NSString *week = [self weekday];
    
    NSDictionary *map = @{@"0" : @"周日",
                          @"1" : @"周一",
                          @"2" : @"周二",
                          @"3" : @"周三",
                          @"4" : @"周四",
                          @"5" : @"周五",
                          @"6" : @"周六",
                          };
    
    return map[week];
}

-(NSString *)firstWeekdayInCurrentMonth
{
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];;
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:self];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    
    return [beginDate weekday];
}

-(NSInteger)daysInCurrentMonth
{
    NSRange range =[calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    
    return range.length;
}

-(NSDate *)dateOffsetMonth:(NSInteger)offset
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.month = offset;
    
    return [calendar dateByAddingComponents:comps toDate:self options:0];
}

-(NSDate *)dateOffsetDay:(NSInteger)offset
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = offset;
    
    return [calendar dateByAddingComponents:comps toDate:self options:0];
}

-(NSDateComponents *)components
{
    return [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:self];
}

+(NSDate *)dateFromSelectIndex:(NSIndexPath *)indexPath
{
    NSDate *date = [[NSDate date] dateOffsetMonth:indexPath.section];
    
    NSInteger day = indexPath.row - [date firstWeekdayInCurrentMonth].integerValue + 1;
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    comp.year = date.components.year;
    comp.month = date.components.month;
    comp.day = day;
    
    return [calendar dateFromComponents:comp];
}

-(NSIndexPath *)indexPath
{
    // 上面的反推 monthOffset 要注意，年末最后一天 和 下一年的一月的处理，所以通过判断若两者月相等section就等于0，不等的话，有可能是大于，有可能是小于(比如当前月2016-12，下个月2017-01)
    NSInteger row = self.components.day-1+[self firstWeekdayInCurrentMonth].integerValue;
    NSInteger monthOffset = (self.components.month == [NSDate date].components.month) ? 0 : 1;
    
    return [NSIndexPath indexPathForRow:row inSection:monthOffset];
}

@end
