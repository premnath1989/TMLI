//
//  ModelCashPlanRate.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/16/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "ModelCashPlanRate.h"
#import "String.h"

@implementation ModelCashPlanRate
-(double)getRateCashPlan:(int)LAAge StringGender:(NSString *)stringGender{
    double rate = 0;
    
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_RATES_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    NSString* stringAge = [NSString stringWithFormat:@"%i",LAAge];
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select %@ from %@ where Age = \"%@\"",stringGender,TABLE_RATES_CASH_PLAN,stringAge]];
    
    rate = [[s stringForColumn:stringGender] doubleValue];
    while ([s next]) {
        rate = [[s stringForColumn:stringGender] doubleValue];
    }
    
    [results close];
    [database close];
    return rate;
}

@end
