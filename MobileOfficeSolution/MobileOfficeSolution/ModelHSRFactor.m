//
//  ModelHSRFactor.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/17/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "ModelHSRFactor.h"
#import "String.h"
@implementation ModelHSRFactor
-(double)getHSRFactor:(int)LAAge{
    double rate = 0;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_RATES_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    NSString* stringAge = [NSString stringWithFormat:@"%i",LAAge];
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select HSR_Factor from %@ where PY = \"%@\"",TABLE_RATES_HSR_FACTOR,stringAge]];
    
    rate = [[s stringForColumn:@"HSR_Factor"] doubleValue];
    while ([s next]) {
        rate = [[s stringForColumn:@"HSR_Factor"] doubleValue];
    }
    
    [results close];
    [database close];
    return rate;
}
@end
