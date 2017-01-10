//
//  ModelOccupation.m
//  BLESS
//
//  Created by Basvi on 8/19/16.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ModelOccupation.h"
#import "String.h"


@implementation ModelOccupation


-(NSString *)getOccupationDesc:(NSString *)occupationCode{
    NSString *stringOccupationDesc;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSString *query = [NSString stringWithFormat:@"SELECT OccpDesc from %@ WHERE occp_Code = %@", TABLE_OCCP, occupationCode, Nil];
    FMResultSet *s = [database executeQuery:query];
    while ([s next]) {
        stringOccupationDesc = [s stringForColumn:@"OccpDesc"];
    }
    
    [results close];
    [database close];
    return stringOccupationDesc;
}


@end
