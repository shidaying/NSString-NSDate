//
//  ViewController.m
//  DateTest
//
//  Created by hour on 15/11/4.
//  Copyright © 2015年 Stone. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //设置转化格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale: [NSLocale currentLocale]];
    [formatter setTimeZone: [NSTimeZone localTimeZone]];
    [formatter setDateStyle: NSDateFormatterMediumStyle];
    [formatter setTimeStyle: NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//HH是24小时制， hh是12小时制, HH:mm:ss里面的 mm 不能大写，否则这个分钟会一直是这个yyyy-MM-dd 里面的MM的值,同时dd和ss都不能大写
    
//    [formatter setDateFormat:@"yyyy年MM月dd日HH时mm分ss秒"];//这样设置也是可行的
    
    //时间戳转化为时间
    NSString *doubleStr = @"1446610423";
    NSDate *dateFromDouble = [NSDate dateWithTimeIntervalSince1970: doubleStr.doubleValue];
    NSLog(@"dateFromDouble = %@", dateFromDouble);
    
    //时间转化为字符串
    NSDate *currentDate = [NSDate date];
    NSLog(@"currentDate = %@", currentDate);
    NSString *strFromDate = [formatter stringFromDate: currentDate];
    NSLog(@"strFromDate = %@", strFromDate);
    
    //时间字符串转化为时间
    NSString *dateStr = @"2015-11-27 15:11:19";
    NSDate *dateFromStr = [formatter dateFromString: dateStr];
    NSLog(@"dateFromStr = %@", dateFromStr);//会出现8小时的时差
    
    //出现8小时时差
    //解决办法一
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *correctDate = [formatter dateFromString: dateStr];
    NSLog(@"correctDate = %@", correctDate);
    
    //解决办法二
    NSTimeZone *sysTimeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [sysTimeZone secondsFromGMTForDate: dateFromStr];
    NSDate *localDate = [dateFromStr dateByAddingTimeInterval:interval];
    NSLog(@"localDate = %@", localDate);
    
    //解决办法三, 这个不太提倡，只是针对于中国
    NSDate *chinaDate = [dateFromStr dateByAddingTimeInterval: 8 * 60 * 60];//加上8个小时的时差
    NSLog(@"chinaDate = %@", chinaDate);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
