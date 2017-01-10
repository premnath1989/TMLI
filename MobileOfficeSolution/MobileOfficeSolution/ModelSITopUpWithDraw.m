//
//  ModelSISpecialRequest.m
//  BLESS
//
//  Created by Basvi on 11/15/16.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ModelSITopUpWithDraw.h"

@implementation ModelSITopUpWithDraw
-(int)getTopUpWithDrawDataCount:(NSString *)SINo Year:(NSString *)stringYear Option:(NSString *)stringOption{
    int count = 0;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select count(*) from SI_TopUpWithDraw where SINO = \"%@\" and Year = \"%@\" and Option = \"%@\"",SINo,stringYear,stringOption]];
    while ([s next]) {
        count = [s intForColumn:@"count(*)"];
    }
    
    [results close];
    [database close];
    return count;
}

-(void)saveTopUpWithDrawData:(NSMutableDictionary *)dictTopUpWithDrawData{
    //cek the SINO exist or not
    /*int exist = [self getTopUpWithDrawDataCount:[dictTopUpWithDrawData valueForKey:@"SINO"] Year:[dictTopUpWithDrawData valueForKey:@"Year"] Option:[dictTopUpWithDrawData valueForKey:@"Option"]];
    
    if (exist>0){
        //update data
        [self updateTopUpWithDrawData:dictTopUpWithDrawData];
    }
    else{
        //insert data
        [self insertToDBTopUpWithDrawData:dictTopUpWithDrawData];
    }*/
    [self insertToDBTopUpWithDrawData:dictTopUpWithDrawData];
}

-(void)insertToDBTopUpWithDrawData:(NSMutableDictionary *)dictTopUpWithDrawData{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    BOOL success = [database executeUpdate:@"insert into SI_TopUpWithDraw (SINO, Year, Amount,Option) values (?,?,?,?)",
                    [dictTopUpWithDrawData valueForKey:@"SINO"],
                    [dictTopUpWithDrawData valueForKey:@"Year"],
                    [dictTopUpWithDrawData valueForKey:@"Amount"],
                    [dictTopUpWithDrawData valueForKey:@"Option"]];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}

-(void)updateTopUpWithDrawData:(NSMutableDictionary *)dictTopUpWithDrawData{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path] ;
    [database open];
    BOOL success = [database executeUpdate:@"update SI_TopUpWithDraw set Year=?, Amount=?, Option=? where SINO=?" ,
                    [dictTopUpWithDrawData valueForKey:@"Year"],
                    [dictTopUpWithDrawData valueForKey:@"Amount"],
                    [dictTopUpWithDrawData valueForKey:@"Option"],
                    [dictTopUpWithDrawData valueForKey:@"SINO"]];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}

-(void)deleteTopUpWithDrawData:(NSString *)stringSINO{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path] ;
    [database open];
    BOOL success = [database executeUpdate:@"delete from SI_TopUpWithDraw where SINO=?" ,
                    stringSINO];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}


-(NSMutableArray *)getTopUpWithDrawDataFor:(NSString *)SINo{
    NSMutableArray* arrayTopUpWithDraw = [[NSMutableArray alloc]init];
    NSDictionary *dict;
    
    NSString *SINO;
    NSString *Year;
    NSString *Amount;
    NSString *Option;
    
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select * from SI_TopUpWithDraw where SINO = \"%@\"",SINo]];
    while ([s next]) {
        SINO = [s stringForColumn:@"SINO"];
        Year = [s stringForColumn:@"Year"];
        Amount = [s stringForColumn:@"Amount"];
        Option = [s stringForColumn:@"Option"];
        
        dict=[[NSDictionary alloc]initWithObjectsAndKeys:
              SINO,@"SINO",
              Year,@"Year",
              Amount,@"Amount",
              Option,@"Option",nil];
        
        [arrayTopUpWithDraw addObject:dict];
    }
    
    
    
    [results close];
    [database close];
    return arrayTopUpWithDraw;
}

-(NSMutableArray *)getTopUpWithDrawDataFor:(NSString *)SINo Option:(NSString *)stringOption{
    NSMutableArray* arrayTopUpWithDraw = [[NSMutableArray alloc]init];
    NSDictionary *dict;
    
    NSString *SINO;
    NSString *Year;
    NSString *Amount;
    NSString *Option;
    
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select * from SI_TopUpWithDraw where SINO = \"%@\" and Option = \"%@\"",SINo,stringOption]];
    while ([s next]) {
        SINO = [s stringForColumn:@"SINO"];
        Year = [s stringForColumn:@"Year"];
        Amount = [s stringForColumn:@"Amount"];
        Option = [s stringForColumn:@"Option"];
        
        dict=[[NSDictionary alloc]initWithObjectsAndKeys:
              SINO,@"SINO",
              Year,@"Year",
              Amount,@"Amount",
              Option,@"Option",nil];
        
        [arrayTopUpWithDraw addObject:dict];
    }
    
    
    
    [results close];
    [database close];
    return arrayTopUpWithDraw;
}

@end
