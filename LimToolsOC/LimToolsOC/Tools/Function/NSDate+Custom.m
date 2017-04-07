//
//  NSDate+Custom.m
//  LimToolsOC
//
//  Created by Liu on 07/04/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "NSDate+Custom.h"

@implementation NSDate (Custom)

- (NSString *)dateConvertToStringWithFormat:(NSString *)formatString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:formatString];// HH:mm:ss zzz
    
    if (formatString == nil) {
        [dateFormatter setDateFormat:@"yyyy年mm月dd日"];
    }
    
    NSString *destDateString = [dateFormatter stringFromDate:self];
    
    return destDateString;
}

- (BOOL)isSameDay:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:self];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}

- (BOOL)isAfterTo:(NSDate *)date;
{
    return [self compare:date] == NSOrderedDescending;
}

- (void)calCoutDownTime:(void(^)(NSDateComponents *dateCom))result {
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
    
    if (result) result(dateCom);
}

- (NSDateComponents *)transDateCompnent
{
    NSCalendar* systemCalender = [NSCalendar currentCalendar];
    NSUInteger unitFlags = kCFCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | kCFCalendarUnitSecond | NSCalendarUnitWeekday;
    return [systemCalender components:unitFlags fromDate:self];
}

- (NSUInteger)getYear;
{
    return [self transDateCompnent].year;
}
- (NSUInteger)getMonth;
{
    return [self transDateCompnent].month;
}
- (NSUInteger)getDay;
{
    return [self transDateCompnent].day;
}
- (NSUInteger)getWeek;
{
    return [self transDateCompnent].weekday + 1;
}
- (NSUInteger)getHour;
{
    return [self transDateCompnent].hour;
}
- (NSUInteger)getHour12;
{
    return [self transDateCompnent].hour%12;
}
- (NSUInteger)getMin;
{
    return [self transDateCompnent].minute;
}
- (NSUInteger)getSecond;
{
    return [self transDateCompnent].second;
}

@end
