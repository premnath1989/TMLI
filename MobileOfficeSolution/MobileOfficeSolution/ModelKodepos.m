//
//  ModelKodepos.m
//  MPOS
//
//  Created by Basvi on 3/16/16.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ModelKodepos.h"
#import "String.h"

@implementation ModelKodepos

-(NSMutableArray *)getPropinsi{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSMutableArray* arrayPropinsiName=[[NSMutableArray alloc] init];

    NSString *query = [NSString stringWithFormat:@"select propinsi from %@ group by propinsi",TABLE_ZIPCODE];
    FMResultSet *s = [database executeQuery:query];
    while ([s next]) {
        NSString *stringPropinsi = [NSString stringWithFormat:@"%@",[s stringForColumn:@"propinsi"]];
        
        [arrayPropinsiName addObject:stringPropinsi];
    }
    [results close];
    [database close];
    return arrayPropinsiName;
}

-(NSMutableArray *)getKabupatengbyPropinsi:(NSString *)propinsi{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSMutableArray* arrayKabupatenName=[[NSMutableArray alloc] init];
    
    NSString *query = [NSString stringWithFormat:@"select kabupaten from %@ where propinsi=\"%@\" group by kabupaten", TABLE_ZIPCODE,propinsi];
    FMResultSet *s = [database executeQuery:query];
    while ([s next]) {
        NSString *stringKabupaten = [NSString stringWithFormat:@"%@",[s stringForColumn:@"kabupaten"]];
        
        [arrayKabupatenName addObject:stringKabupaten];
    }
    [results close];
    [database close];
    return arrayKabupatenName;
}

@end
