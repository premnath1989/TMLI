//
//  ModelCI55Rates.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/16/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "ModelCI55Rates.h"
#import "String.h"
@implementation ModelCI55Rates
-(double)getRateCI55:(int)LAAge StringGender:(NSString *)stringGender{
    double rate = 0;
    
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_RATES_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    NSString* stringAge = [NSString stringWithFormat:@"%i",LAAge];
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select %@ from %@ where Age =\"%@\"",stringGender,TABLE_RATES_CI55,stringAge]];
    
    rate = [[s stringForColumn:stringGender] doubleValue];
    while ([s next]) {
        rate = [[s stringForColumn:stringGender] doubleValue];
    }
    
    [results close];
    [database close];
    return rate;
}

@end
