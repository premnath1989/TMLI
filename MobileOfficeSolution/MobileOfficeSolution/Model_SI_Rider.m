//
//  Model_SI_Rider.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/9/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "Model_SI_Rider.h"
#import "String.h"

@implementation Model_SI_Rider
-(int)getRiderDataCount:(NSString *)SINo{
    int count = 0;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select count(*) from SI_Rider where SINO = \"%@\"",SINo]];
    while ([s next]) {
        count = [s intForColumn:@"count(*)"];
    }
    
    [results close];
    [database close];
    return count;
}

-(void)saveRiderData:(NSMutableDictionary *)dictRiderData{
    //cek the SINO exist or not
    //int exist = [self getRiderDataCount:[dictRiderData valueForKey:@"SINO"]];
    
    /*if (exist>0){
     //update data
     [self updateRiderData:dictRiderData];
     }
     else{
     //insert data
     [self insertToDBRiderData:dictRiderData];
     }*/
    [self insertToDBRiderData:dictRiderData];
}

-(void)deleteRiderData:(NSString *)stringSINO{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path] ;
    [database open];
    BOOL success = [database executeUpdate:@"delete from SI_Rider where SINO=?" ,
                    stringSINO];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}

-(void)insertToDBRiderData:(NSMutableDictionary *)dictRiderData{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    BOOL success = [database executeUpdate:@"insert into SI_Rider (SINO, RiderCode, RiderDesc, SumAssured,Term,ExtraPremiMil,ExtraPremiMilTerm,ExtraPremiPercent,ExtraPremiPercentTerm) values (?,?,?,?,?,?,?,?,?)",
                    [dictRiderData valueForKey:@"SINO"],
                    [dictRiderData valueForKey:@"RiderCode"],
                    [dictRiderData valueForKey:@"RiderDesc"],
                    [dictRiderData valueForKey:@"SumAssured"],
                    [dictRiderData valueForKey:@"Term"],
                    [dictRiderData valueForKey:@"ExtraPremiMil"],
                    [dictRiderData valueForKey:@"ExtraPremiMilTerm"],
                    [dictRiderData valueForKey:@"ExtraPremiPercent"],
                    [dictRiderData valueForKey:@"ExtraPremiPercentTerm"]];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}

-(void)updateRiderData:(NSMutableDictionary *)dictRiderData{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path] ;
    [database open];
    BOOL success = [database executeUpdate:@"update SI_Rider set RiderCode=?, RiderDesc=?, SumAssured=?,Term=?,ExtraPremiMil=?,ExtraPremiMilTerm=?,ExtraPremiPercent=?,ExtraPremiPercentTerm=? where SINO=?" ,
                    [dictRiderData valueForKey:@"RiderCode"],
                    [dictRiderData valueForKey:@"RiderDesc"],
                    [dictRiderData valueForKey:@"SumAssured"],
                    [dictRiderData valueForKey:@"Term"],
                    [dictRiderData valueForKey:@"ExtraPremiMil"],
                    [dictRiderData valueForKey:@"ExtraPremiMilTerm"],
                    [dictRiderData valueForKey:@"ExtraPremiPercent"],
                    [dictRiderData valueForKey:@"ExtraPremiPercentTerm"],
                    [dictRiderData valueForKey:@"SINO"]];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}

-(NSMutableArray *)getRiderDataFor:(NSString *)SINo{
    NSMutableArray* arrayRiderData = [[NSMutableArray alloc]init];
    NSDictionary *dict;
    
    NSString* SINO;
    NSString* RiderCode;
    NSString* RiderDesc;
    NSString* SumAssured;
    NSString* Term;
    NSString* ExtraPremiMil;
    NSString* ExtraPremiMilTerm;
    NSString* ExtraPremiPercent;
    NSString* ExtraPremiPercentTerm;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select * from SI_Rider where SINO = \"%@\"",SINo]];
    while ([s next]) {
        SINO = [s stringForColumn:@"SINO"];
        RiderCode = [s stringForColumn:@"RiderCode"];
        RiderDesc = [s stringForColumn:@"RiderDesc"];
        SumAssured = [s stringForColumn:@"SumAssured"];
        Term = [s stringForColumn:@"Term"];
        ExtraPremiMil = [s stringForColumn:@"ExtraPremiMil"];
        ExtraPremiMilTerm = [s stringForColumn:@"ExtraPremiMilTerm"];
        ExtraPremiPercent = [s stringForColumn:@"ExtraPremiPercent"];
        ExtraPremiPercentTerm = [s stringForColumn:@"ExtraPremiPercentTerm"];
        
        dict=[[NSDictionary alloc]initWithObjectsAndKeys:
              SINO,@"SINO",
              RiderCode,@"RiderCode",
              RiderDesc,@"RiderDesc",
              SumAssured,@"SumAssured",
              Term,@"Term",
              ExtraPremiMil,@"ExtraPremiMil",
              ExtraPremiMilTerm,@"ExtraPremiMilTerm",
              ExtraPremiPercent,@"ExtraPremiPercent",
              ExtraPremiPercentTerm,@"ExtraPremiPercentTerm",nil];
        
        [arrayRiderData addObject:dict];
    }
    
    
    [results close];
    [database close];
    return arrayRiderData;
}
@end
