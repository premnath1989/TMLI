//
//  ModelCIEERates.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/16/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "ModelCIEERates.h"
#import "String.h"
@implementation ModelCIEERates
-(double)getRateCIEE:(int)LAAge StringGender:(NSString *)stringGender{
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
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select %@ from %@ where Age = %i",stringTableGender,TABLE_RATES_CIEE,LAAge]];
    
    rate = [s doubleForColumn:stringTableGender];
    while ([s next]) {
        rate = [s doubleForColumn:stringTableGender];
    }
    
    [results close];
    [database close];
    return rate;
}

@end
