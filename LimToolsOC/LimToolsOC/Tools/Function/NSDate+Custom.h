//
//  NSDate+Custom.h
//  LimToolsOC
//
//  Created by Liu on 07/04/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Custom)
- (NSString *)dateConvertToStringWithFormat:(NSString *)formatString;
- (BOOL)isSameDay:(NSDate *)date;
- (BOOL)isAfterTo:(NSDate *)date;

/**
 *  计算指定Date距离今天的值
 *
 *  @param result 返回结果
 */
- (void)calCoutDownTime:(void(^)(NSDateComponents *dateCom))result;

- (NSUInteger)getYear;
- (NSUInteger)getMonth;
- (NSUInteger)getDay;
- (NSUInteger)getWeek;
- (NSUInteger)getHour;
- (NSUInteger)getHour12;
- (NSUInteger)getMin;
- (NSUInteger)getSecond;
@end
