//
//  ModelSIFundAllocation.m
//  BLESS
//
//  Created by Basvi on 11/15/16.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ModelSIFundAllocation.h"

@implementation ModelSIFundAllocation
-(int)getFundAllocationDataCount:(NSString *)SINo{
    int count = 0;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select count(*) from SI_FundAllocation where SINO = \"%@\"",SINo]];
    while ([s next]) {
        count = [s intForColumn:@"count(*)"];
    }
    
    [results close];
    [database close];
    return count;
}

-(void)saveFundAllocationData:(NSMutableDictionary *)dictFundAllocationData{
    
    //cek the SINO exist or not
    /*int exist = [self getFundAllocationDataCount:[dictFundAllocationData valueForKey:@"SINO"]];
    
    if (exist>0){
        //update data
        [self updateFundAllocationData:dictFundAllocationData];
    }
    else{
        //insert data
        [self insertToDBFundAllocationData:dictFundAllocationData];
    }*/
     [self insertToDBFundAllocationData:dictFundAllocationData];
}

-(void)deleteFundAllocationData:(NSString *)stringSINO{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path] ;
    [database open];
    BOOL success = [database executeUpdate:@"delete from SI_FundAllocation where SINO=?" ,
                    stringSINO];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}


-(void)insertToDBFundAllocationData:(NSMutableDictionary *)dictFundAllocationData{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    BOOL success = [database executeUpdate:@"insert into SI_FundAllocation (SINO, FundID, FundName, FundValue,FundGrowthLow,FundGrowthMiddle,FundGrowthHigh) values (?,?,?,?,?,?,?)",
                    [dictFundAllocationData valueForKey:@"SINO"],
                    [dictFundAllocationData valueForKey:@"FundID"],
                    [dictFundAllocationData valueForKey:@"FundName"],
                    [dictFundAllocationData valueForKey:@"FundValue"],
                    [dictFundAllocationData valueForKey:@"FundGrowthLow"],
                    [dictFundAllocationData valueForKey:@"FundGrowthMiddle"],
                    [dictFundAllocationData valueForKey:@"FundGrowthHigh"]];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}

-(void)updateFundAllocationData:(NSMutableDictionary *)dictFundAllocationData{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path] ;
    [database open];
    BOOL success = [database executeUpdate:@"update SI_FundAllocation set FundID=?, FundName=?, FundValue=? where SINO=?" ,
                    [dictFundAllocationData valueForKey:@"FundID"],
                    [dictFundAllocationData valueForKey:@"FundName"],
                    [dictFundAllocationData valueForKey:@"FundValue"],
                    [dictFundAllocationData valueForKey:@"SINO"]];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}

-(NSMutableArray *)getFundAllocationDataFor:(NSString *)SINo{
    NSMutableArray* fundAllocData = [[NSMutableArray alloc]init];
    NSDictionary *dict;
    
    NSString* SINO;
    NSString* FundID;
    NSString* FundName;
    NSString* FundValue;
    
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select * from SI_FundAllocation where SINO = \"%@\"",SINo]];
    while ([s next]) {
        SINO = [s stringForColumn:@"SINO"];
        FundID = [s stringForColumn:@"FundID"];
        FundName = [s stringForColumn:@"FundName"];
        FundValue = [s stringForColumn:@"FundValue"];
        
        dict=[[NSDictionary alloc]initWithObjectsAndKeys:
              SINO,@"SINO",
              FundID,@"FundID",
              FundName,@"FundName",
              FundValue,@"FundValue",
              nil];
        [fundAllocData addObject:dict];
    }
    
    
    [results close];
    [database close];
    return fundAllocData;
}
@end
