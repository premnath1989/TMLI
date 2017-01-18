//
//  ModelHSRCOR.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/17/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "ModelHSRCOR.h"
#import "String.h"
@implementation ModelHSRCOR
-(double)getHSRCOR:(int)LAAge StringPlanCode:(NSString *)stringPlanCode{
    double rate = 0;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select %@ from %@ where Age = %i",stringPlanCode,TABLE_RATES_HSR_COR,LAAge]];
    
    rate = [s doubleForColumn:stringPlanCode];
    while ([s next]) {
        rate = [s doubleForColumn:stringPlanCode];
    }
    
    [results close];
    [database close];
    return rate;
}
@end
