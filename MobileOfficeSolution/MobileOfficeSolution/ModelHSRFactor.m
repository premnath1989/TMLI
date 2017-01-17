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
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select PY from %@ where Age = %i",TABLE_RATES_HSR_FACTOR,LAAge]];
    
    rate = [s doubleForColumn:@"PY"];
    while ([s next]) {
        rate = [s doubleForColumn:@"PY"];
    }
    
    [results close];
    [database close];
    return rate;
}
@end
