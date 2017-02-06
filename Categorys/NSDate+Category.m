//
//  NSDate+Category.m
//  CXTools
//
//  Created by 曹云霄 on 16/9/22.
//  Copyright © 2016年 上海勾芒科技信息有限公司. All rights reserved.
//

#import "NSDate+Category.h"

#include <time.h>
#include <xlocale.h>

#define JTLocalizedString(key) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

#define ISO8601_MAX_LEN 25

@implementation NSDate (Category)
- (NSString *)yearString {
    NSString *strDate = [self yearMonthDayString];
    NSArray *arrDate = [strDate componentsSeparatedByString:@"-"];
    return arrDate[0];
}
- (NSString *)monthString {
    NSString *strDate = [self yearMonthDayString];
    NSArray *arrDate = [strDate componentsSeparatedByString:@"-"];
    return arrDate[1];
}
- (NSString *)dayString{
    NSString *strDate = [self yearMonthDayString];
    NSArray *arrDate = [strDate componentsSeparatedByString:@"-"];
    return arrDate[2];
}

- (NSString *)yearWeekString {
    NSInteger week = [self getWeekOfYear];
    NSString  *year = [self yearString];
    return  [NSString stringWithFormat:@"%@-%ld",year, (long)week];
}

+ (NSDate *)dateFromISO8601String:(NSString *)iso8601 {
    if (!iso8601) {
        return nil;
    }
    
    const char *str = [iso8601 cStringUsingEncoding:NSUTF8StringEncoding];
    char newStr[ISO8601_MAX_LEN];
    bzero(newStr, ISO8601_MAX_LEN);
    
    size_t len = strlen(str);
    if (len == 0) {
        return nil;
    }
    
    // UTC dates ending with Z
    if (len == 20 && str[len - 1] == 'Z') {
        memcpy(newStr, str, len - 1);
        strncpy(newStr + len - 1, "+0000\0", 6);
    }
    
    // Timezone includes a semicolon (not supported by strptime)
    else if (len == 25 && str[22] == ':') {
        memcpy(newStr, str, 22);
        memcpy(newStr + 22, str + 23, 2);
    }
    
    // Fallback: date was already well-formatted OR any other case (bad-formatted)
    else {
        memcpy(newStr, str, len > ISO8601_MAX_LEN - 1 ? ISO8601_MAX_LEN - 1 : len);
    }
    
    // Add null terminator
    newStr[sizeof(newStr) - 1] = 0;
    
    struct tm tm = {
        .tm_sec = 0,
        .tm_min = 0,
        .tm_hour = 0,
        .tm_mday = 0,
        .tm_mon = 0,
        .tm_year = 0,
        .tm_wday = 0,
        .tm_yday = 0,
        .tm_isdst = -1,
    };
    
    if (strptime_l(newStr, "%FT%T%z", &tm, NULL) == NULL) {
        return nil;
    }
    
    return [NSDate dateWithTimeIntervalSince1970:mktime(&tm)];
}


- (NSString *)ISO8601String {
    struct tm *timeinfo;
    char buffer[80];
    
    time_t rawtime = (time_t)[self timeIntervalSince1970];
    timeinfo = gmtime(&rawtime);
    
    strftime(buffer, 80, "%Y-%m-%dT%H:%M:%SZ", timeinfo);
    
    return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

+ (NSString *)stringWithFormatter:(NSString *)dateFormatter andDate:(NSDate *)date {
    if ([dateFormatter length] == 0) {
        return nil;
    }
    
    struct tm *timeinfo;
    char buffer[80];
    
    time_t rawtime = (time_t)[date timeIntervalSince1970];
    timeinfo = gmtime(&rawtime);
    
    strftime(buffer, 80, [dateFormatter UTF8String], timeinfo);
    
    return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

- (NSString *)stringWithFormatter:(NSString *)dateFormatter {
    
    if ([dateFormatter length] == 0) {
        return nil;
    }
    
    // Change to Local time zone
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:self];
    NSDate *localDate = [self dateByAddingTimeInterval: interval];
    
    return [[self class] stringWithFormatter:dateFormatter andDate:localDate];
}

- (NSString *)chatAttachmentFormatterString {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:self];
    NSDate *localDate = [self dateByAddingTimeInterval: interval];
    
    NSString *dateFormatter = @"%m/%d/%Y %H:%M:%S";
    
    return [[self class] stringWithFormatter:dateFormatter andDate:localDate];
}

- (NSString *)YMDHMSFormatterString {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:self];
    NSDate *localDate = [self dateByAddingTimeInterval: interval];
    
    NSString *dateFormatter = @"%Y%m%d%H%M%S";
    
    return [[self class] stringWithFormatter:dateFormatter andDate:localDate];
}

- (NSString *)chatMsgFormatterString {
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:self];
    NSDate *localDate = [self dateByAddingTimeInterval: interval];
    
    NSDate *tmpDate = [NSDate date];
    interval = [zone secondsFromGMTForDate:tmpDate];
    NSDate *localCurDate = [tmpDate dateByAddingTimeInterval: interval];
    
    NSString *dateFormatter = @"%Y-%m-%d-%H-%M-%S";
    
    NSString *dateStr = [[self class] stringWithFormatter:dateFormatter andDate:localDate];
    NSString *currentDateStr = [[self class] stringWithFormatter:dateFormatter andDate:localCurDate];
    
    NSArray *dateComponents = [dateStr componentsSeparatedByString:@"-"];
    NSArray *currentDateComponents = [currentDateStr componentsSeparatedByString:@"-"];
    
    // Year
    if (![dateComponents[ 0 ] isEqualToString:currentDateComponents[ 0 ]]) {
        dateFormatter = @"%Y-%m";
    }
    // Month
    else if (![dateComponents[ 1 ] isEqualToString:currentDateComponents[ 1 ]]) {
        dateFormatter = @"%m-%d";
    }
    // Day
    else if (![dateComponents[ 2 ] isEqualToString:currentDateComponents[ 2 ]]) {
        dateFormatter = @"%m-%d";
    }
    // Min
    else if (![dateComponents[ 3 ] isEqualToString:currentDateComponents[ 3 ]]) {
        dateFormatter = @"%H:%M";
    }
    // Sec
    else {
        dateFormatter = @"%H:%M";
    }
    
    return [[self class] stringWithFormatter:dateFormatter andDate:localDate];
}

- (NSString *)briefTimeInWords {
    NSTimeInterval seconds = fabs([self timeIntervalSinceNow]);
    
    static NSNumberFormatter *numberFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        numberFormatter.currencySymbol = @"";
        numberFormatter.maximumFractionDigits = 0;
    });
    
    // Seconds
    if (seconds < 60.0) {
        if (seconds < 2.0) {
            return JTLocalizedString(@"1s");
        }
        return [NSString stringWithFormat:JTLocalizedString(@"%ds"), (NSInteger)seconds];
    }
    
    NSTimeInterval minutes = round(seconds / 60.0);
    
    // Minutes
    if (minutes >= 0.0 && minutes < 60.0) {
        if (minutes < 2.0) {
            return JTLocalizedString(@"1m");
        }
        return [NSString stringWithFormat:JTLocalizedString(@"%dm"), (NSInteger)minutes];
    }
    
    // Hours
    else if (minutes >= 60.0 && minutes < 1440.0) {
        NSInteger hours = (NSInteger)round(minutes / 60.0);
        if (hours < 2) {
            return JTLocalizedString(@"1h");
        }
        return [NSString stringWithFormat:JTLocalizedString(@"%dh"), hours];
    }
    
    // Days
    else if (minutes >= 1440.0 && minutes < 525600.0) {
        NSInteger days = (NSInteger)round(minutes / 1440.0);
        if (days < 2) {
            return JTLocalizedString(@"1d");
        }
        return [NSString stringWithFormat:JTLocalizedString(@"%@d"),
                [numberFormatter stringFromNumber:[NSNumber numberWithInteger:days]]];
    }
    
    // Years
    else if (minutes >= 525600.0) {
        NSInteger years = (NSInteger)round(minutes / 525600.0);
        if (years < 2) {
            return JTLocalizedString(@"1y");
        }
        return [NSString stringWithFormat:JTLocalizedString(@"%@y"),
                [numberFormatter stringFromNumber:[NSNumber numberWithInteger:years]]];
    }
    
    return nil;
}

- (NSString *)localYMDString {
    return [self stringWithFormatter:@"%Y-%m-%d"];
}


- (NSString *)briefTimeForTimeLine {
    NSTimeInterval seconds = fabs([self timeIntervalSinceNow]);
    
    static NSNumberFormatter *numberFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        numberFormatter.currencySymbol = @"";
        numberFormatter.maximumFractionDigits = 0;
    });
    
    NSTimeInterval minutes = round(seconds / 60.0);
    
    // Minutes
    if (minutes >= 0.0 && minutes < 60.0) {
        if (minutes < 2.0) {
            return JTLocalizedString(@"1m");
        }
        return [NSString stringWithFormat:JTLocalizedString(@"%dm"), (NSInteger)minutes];
    }
    
    // Hours
    else if (minutes >= 60.0 && minutes < 1440.0) {
        NSInteger hours = (NSInteger)round(minutes / 60.0);
        if (hours < 2) {
            return JTLocalizedString(@"1h");
        }
        return [NSString stringWithFormat:JTLocalizedString(@"%dh"), hours];
    }
    
    // in 7 Days
    else if (minutes >= 1440.0 && minutes < 10080.0) {
        NSInteger days = (NSInteger)round(minutes / 1440.0);
        if (days < 2) {
            return JTLocalizedString(@"1d");
        }
        return [NSString stringWithFormat:JTLocalizedString(@"%@d"),
                [numberFormatter stringFromNumber:[NSNumber numberWithInteger:days]]];
    }
    
    // > 7 Days
    else if (minutes >= 10080.0) {
        return [self stringWithFormatter:@"%m/%d/%Y"];
    }
    
    return nil;
}

- (NSString *)httpParameterString {
    return [self stringWithFormatter:@"%Y-%m-%d %H:%M:%S"];
}
- (NSString *)yearMonthDayString {
    return [self stringWithFormatter:@"%Y-%m-%d"];
}
- (NSString *)yearMonthString {
    return [self stringWithFormatter:@"%Y-%m"];
}
- (NSString *)mobileIDDateString {
    return [self stringWithFormatter:@"%y%m%d%H%M%S000"];
}

- (NSDate *)endOfTheDay {
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute);
    NSDateComponents *comp = [calendar components:preservedComponents fromDate:self];
    [comp setMinute:59];
    [comp setHour:23];
    
    return [calendar dateFromComponents:comp];
}

- (NSNumber *)timeStampNumber
{
    NSString *timeStampString = [self timeStampStr];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * time = [f numberFromString:timeStampString];
    return time;
}

+ (NSString *)timeInWordsFromTimeInterval:(NSTimeInterval)intervalInSeconds includingSeconds:(BOOL)includeSeconds {
    NSTimeInterval intervalInMinutes = round(intervalInSeconds / 60.0f);
    
    if (intervalInMinutes >= 0 && intervalInMinutes <= 1) {
        if (!includeSeconds) {
            return intervalInMinutes <= 0 ? JTLocalizedString(@"less than a minute") : JTLocalizedString(@"1 minute");
        }
        if (intervalInSeconds >= 0 && intervalInSeconds < 5) {
            return [NSString stringWithFormat:JTLocalizedString(@"less than %d seconds"), 5];
        } else if (intervalInSeconds >= 5 && intervalInSeconds < 10) {
            return [NSString stringWithFormat:JTLocalizedString(@"less than %d seconds"), 10];
        } else if (intervalInSeconds >= 10 && intervalInSeconds < 20) {
            return [NSString stringWithFormat:@"%d seconds", 20];
        } else if (intervalInSeconds >= 20 && intervalInSeconds < 40) {
            return JTLocalizedString(@"half a minute");
        } else if (intervalInSeconds >= 40 && intervalInSeconds < 60) {
            return JTLocalizedString(@"less than a minute");
        } else {
            return JTLocalizedString(@"1 minute");
        }
    } else if (intervalInMinutes >= 2 && intervalInMinutes <= 44) {
        return [NSString stringWithFormat:JTLocalizedString(@"%d minutes"), (NSInteger)intervalInMinutes];
    } else if (intervalInMinutes >= 45 && intervalInMinutes <= 89) {
        return JTLocalizedString(@"about 1 hour");
    } else if (intervalInMinutes >= 90 && intervalInMinutes <= 1439) {
        return [NSString stringWithFormat:JTLocalizedString(@"about %d hours"), (NSInteger)round(intervalInMinutes / 60.0f)];
    } else if (intervalInMinutes >= 1440 && intervalInMinutes <= 2879) {
        return JTLocalizedString(@"1 day");
    } else if (intervalInMinutes >= 2880 && intervalInMinutes <= 43199) {
        return [NSString stringWithFormat:JTLocalizedString(@"%d days"), (NSInteger)round(intervalInMinutes / 1440.0f)];
    } else if (intervalInMinutes >= 43200 && intervalInMinutes <= 86399) {
        return JTLocalizedString(@"about 1 month");
    } else if (intervalInMinutes >= 86400 && intervalInMinutes <= 525599) {
        return [NSString stringWithFormat:JTLocalizedString(@"%d months"), (NSInteger)round(intervalInMinutes / 43200.0f)];
    } else if (intervalInMinutes >= 525600 && intervalInMinutes <= 1051199) {
        return JTLocalizedString(@"about 1 year");
    } else {
        return [NSString stringWithFormat:JTLocalizedString(@"over %d years"), (NSInteger)round(intervalInMinutes / 525600.0f)];
    }
    return nil;
}

/** 该日期是该年的第几周 */
- (NSInteger)getWeekOfYear
{
    NSInteger i;
    NSInteger year = [self getYear];
    NSDate *date = [self endOfWeek];
    for (i = 1;[[date dateAfterDay:-7 * i] getYear] == year;i++)
    {
    }
    return i;
}
//获取年
- (NSUInteger)getYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:self];
    return [dayComponents year];
}

//返回当前周的周末
- (NSDate *)endOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:(7 - [weekdayComponents weekday])];
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    //    [componentsToAdd release];
    
    return endOfWeek;
}

//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)dateAfterDay:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterDay;
}

- (NSString *)timeInWords {
    return [self timeInWordsIncludingSeconds:YES];
}


- (NSString *)timeInWordsIncludingSeconds:(BOOL)includeSeconds {
    return [[self class] timeInWordsFromTimeInterval:fabs([self timeIntervalSinceNow]) includingSeconds:includeSeconds];
}


+ (NSString *)weekFromeDateString:(NSString *)dateString {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyy-MM-dd"];
    NSDate *date = [f dateFromString:dateString];
    return [self getWeekDayByDate:date];
}

//计算星期几
+ (NSString *)getWeekDayByDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekComp = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekDayEnum = [weekComp weekday];
    NSString *weekDays = nil;
    switch (weekDayEnum) {
        case 1:
            weekDays = @"星期日";
            break;
        case 2:
            weekDays = @"星期一";
            break;
        case 3:
            weekDays = @"星期二";
            break;
        case 4:
            weekDays = @"星期三";
            break;
        case 5:
            weekDays = @"星期四";
            break;
        case 6:
            weekDays = @"星期五";
            break;
        case 7:
            weekDays = @"星期六";
            break;
        default:
            break;
    }
    return weekDays;
}

@end

@implementation NSDate (DateFormatterAdditions)

- (NSString *)timeStampStr {
    NSTimeInterval curTimeInterval = [self timeIntervalSince1970];
    
    NSString *result = [NSString stringWithFormat:@"%li", (unsigned long)curTimeInterval];
    
    while ([result length] < 13) {
        result = [result stringByAppendingString:@"0"];
    }
    
    return result;
}

+ (NSString *)curTimeStamp {
    return [[NSDate date] timeStampStr];
}

@end


@implementation NSDate (DateCalculate)
- (NSDate *)dateAddHourse: (NSUInteger)hourse {
    NSTimeInterval curTimeInterval = [self timeIntervalSince1970];
    NSTimeInterval totalTimeInterval = curTimeInterval + hourse * 3600;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:totalTimeInterval];
    return date;
}
@end



@implementation NSNumber (DateFormatterAdditions)

- (NSDate *)dateValue {
    if (self) {
        return [NSDate dateWithTimeIntervalSince1970:[self integerValue]];
    }
    else {
        return nil;
    }
}

- (NSDate *)overZeroDateValue {
    if (self) {
        NSInteger iSelf = [self integerValue];
        if (iSelf > 0) {
            return [NSDate dateWithTimeIntervalSince1970:iSelf];
        }
        else {
            return nil;
        }
    }
    else {
        return nil;
    }
}

@end

@implementation NSString (DateFormatterAdditions)

- (NSTimeInterval)timeStamp {
    if (self.length > 10) {
        return [[self substringToIndex:10] integerValue];
    }
    else {
        return [self integerValue];
    }
}

- (NSDate *)dateValue {
    if (self) {
        return [NSDate dateWithTimeIntervalSince1970:[self timeStamp]];
    }
    else {
        return nil;
    }
}

- (NSDate *)overZeroDateValue {
    if (self) {
        NSInteger iSelf = [self timeStamp];
        if (iSelf > 0) {
            return [NSDate dateWithTimeIntervalSince1970:iSelf];
        }
        else {
            return nil;
        }
    }
    else {
        return nil;
    }
}

@end
