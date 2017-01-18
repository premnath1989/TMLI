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
    
    NSString* stringTableGender;
    if([stringGender caseInsensitiveCompare:@"male"] == NSOrderedSame) {
        stringTableGender = @"Male";
    }
    else if([stringGender caseInsensitiveCompare:@"female"] == NSOrderedSame) {
        stringTableGender = @"Female";
    }
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select %@ from %@ where Age = %i",stringTableGender,TABLE_RATES_CASH_PLAN,LAAge]];
    
    rate = [s doubleForColumn:stringTableGender];
    while ([s next]) {
        rate = [s doubleForColumn:stringTableGender];
    }
    
    [results close];
    [database close];
    return rate;
}

@end
