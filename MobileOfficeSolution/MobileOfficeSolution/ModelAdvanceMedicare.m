//
//  ModelAdvanceMedicare.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/16/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "ModelAdvanceMedicare.h"
#import "String.h"
@implementation ModelAdvanceMedicare
-(double)getRateAdvanceMedicare:(int)LAAge StringPlan:(NSString *)stringPlan{
    double rate = 0;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select %@ from %@ where Age = %i",stringPlan,TABLE_RATES_ADVANCE_MEDICARE,LAAge]];
    
    rate = [s doubleForColumn:stringPlan];
    while ([s next]) {
        rate = [s doubleForColumn:stringPlan];
    }
    
    [results close];
    [database close];
    return rate;
}
@end
