//
//  DateFormatter.m
//  MobileOfficeSolution
//
//  Created by Erwin Lim  on 1/10/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

- (NSString *)DateMonthName:(NSString *)BareDate prevFormat:(NSDateFormatter *) prevFormat{
    NSDate *dateDOB = [prevFormat dateFromString:BareDate];
    
    return [self DateMonthNoFormat:dateDOB];
}


- (NSString *)DateMonthNoFormat:(NSDate *)BareDate{
    NSDateFormatter *day = [[NSDateFormatter alloc] init];
    [day setDateFormat:@"dd"];
    NSString *txtDay = [day stringFromDate:BareDate];
    
    NSDateFormatter *Month = [[NSDateFormatter alloc] init];
    [Month setDateFormat:@"MM"];
    NSString *txtMonth = [Month stringFromDate:BareDate];
    switch ([[Month stringFromDate:BareDate] integerValue]) {
        case 1:
            txtMonth = @"Jan";
            break;
        case 2:
            txtMonth = @"Feb";
            break;
        case 3:
            txtMonth = @"Mar";
            break;
        case 4:
            txtMonth = @"Apr";
            break;
        case 5:
            txtMonth = @"May";
            break;
        case 6:
            txtMonth = @"Jun";
            break;
        case 7:
            txtMonth = @"Jul";
            break;
        case 8:
            txtMonth = @"Aug";
            break;
        case 9:
            txtMonth = @"Sep";
            break;
        case 10:
            txtMonth = @"Oct";
            break;
        case 11:
            txtMonth = @"Nov";
            break;
        case 12:
            txtMonth = @"Dec";
            break;
            
        default:
            break;
    }
    
    NSDateFormatter *Year = [[NSDateFormatter alloc] init];
    [Year setDateFormat:@"YYYY"];
    NSString *txtYear = [Year stringFromDate:BareDate];
    
    return [NSString stringWithFormat:@"%@-%@-%@", txtDay,txtMonth,txtYear];

}

@end
