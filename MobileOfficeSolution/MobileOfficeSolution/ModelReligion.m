//
//  ModelReligion.m
//  MPOS
//
//  Created by Basvi on 2/3/16.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ModelReligion.h"
#import "String.h"

@implementation ModelReligion

-(NSDictionary *)getReligion{
    NSDictionary *dict;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSMutableArray* arrayReligionCode=[[NSMutableArray alloc] init];
    NSMutableArray* arrayReligionDesc=[[NSMutableArray alloc] init];
    NSMutableArray* arrayStatus=[[NSMutableArray alloc] init];
    
    [arrayReligionCode addObject:@""];
    [arrayReligionDesc addObject:@"- SELECT -"];
    [arrayStatus addObject:@""];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE status = 'A'", TABLE_RELIGION];
    FMResultSet *s = [database executeQuery:query];
    while ([s next]) {
        NSString *ReligionCode = [NSString stringWithFormat:@"%@",[s stringForColumn:@"ReligionCode"]];
        NSString *ReligionDesc = [NSString stringWithFormat:@"%@",[s stringForColumn:@"ReligionDesc"]];
        NSString *Status = [NSString stringWithFormat:@"%@",[s stringForColumn:@"Status"]];
        
        [arrayReligionCode addObject:ReligionCode];
        [arrayReligionDesc addObject:ReligionDesc];
        [arrayStatus addObject:Status];
    }
    dict = [[NSDictionary alloc] initWithObjectsAndKeys:arrayReligionCode,@"ReligionCode", arrayReligionDesc,@"ReligionDesc",arrayStatus,@"Status",nil];
    
    [results close];
    [database close];
    return dict;
}

@end
