//
//  ModelSIRiderSelected.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/13/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "ModelSIRiderSelected.h"
#import "String.h"

@implementation ModelSIRiderSelected
-(int)getRiderDataCount:(NSString *)SINo{
    int count = 0;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select count(*) from %@ where SINO = \"%@\"",TABLE_SI_RIDER_SELECTED,SINo]];
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
    BOOL success = [database executeUpdate:[NSString stringWithFormat:@"delete from %@ where SINO = \"%@\"",TABLE_SI_RIDER_SELECTED,stringSINO]];
    
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
    NSString *stringQuery = [NSString stringWithFormat:@"insert into %@ (SINO, SI_RiderPlan_ID, SI_RiderSelected_Benefit, SI_RiderSelected_COR,SI_RiderSelected_Term,SI_RiderSelected_ExtraPremi_Percent,SI_RiderSelected_ExtraPremi_Mil,SI_RiderSelected_ExtraPremi_Term) values (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",TABLE_SI_RIDER_SELECTED,
                             [dictRiderData valueForKey:@"SINO"],
                             [dictRiderData valueForKey:@"SI_RiderPlan_ID"],
                             [dictRiderData valueForKey:@"SI_RiderSelected_Benefit"],
                             [dictRiderData valueForKey:@"SI_RiderSelected_COR"],
                             [dictRiderData valueForKey:@"SI_RiderSelected_Term"],
                             [dictRiderData valueForKey:@"SI_RiderSelected_ExtraPremi_Percent"],
                             [dictRiderData valueForKey:@"SI_RiderSelected_ExtraPremi_Mil"],
                             [dictRiderData valueForKey:@"SI_RiderSelected_ExtraPremi_Term"]];
    BOOL success = [database executeUpdate:stringQuery];
    
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
    BOOL success = [database executeUpdate:@"update %@ set SI_RiderSelected_Benefit=?,SI_RiderSelected_COR=?,SI_RiderSelected_Term=?,SI_RiderSelected_ExtraPremi_Percent=?,SI_RiderSelected_ExtraPremi_Mil=?,SI_RiderSelected_ExtraPremi_Term=? where SINO=?" ,
                    [dictRiderData valueForKey:@"SI_RiderSelected_Benefit"],
                    [dictRiderData valueForKey:@"SI_RiderSelected_COR"],
                    [dictRiderData valueForKey:@"SI_RiderSelected_Term"],
                    [dictRiderData valueForKey:@"SI_RiderSelected_ExtraPremi_Percent"],
                    [dictRiderData valueForKey:@"SI_RiderSelected_ExtraPremi_Mil"],
                    [dictRiderData valueForKey:@"SI_RiderSelected_ExtraPremi_Term"],
                    [dictRiderData valueForKey:@"SINO"]];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}

-(NSMutableArray *)getRiderSelectedDataFor:(NSString *)SINo{
    NSMutableArray* arrayRiderSelectedData = [[NSMutableArray alloc]init];
    NSDictionary *dict;
    
    NSString* SINO;
    int SI_RiderPlan_ID;
    NSString* SI_RiderPlan_Desc;
    NSString* SI_RiderSelected_Benefit;
    NSString* SI_RiderSelected_COR;
    NSString* SI_RiderSelected_Term;
    NSString* SI_RiderSelected_ExtraPremi_Percent;
    NSString* SI_RiderSelected_ExtraPremi_Mil;
    NSString* SI_RiderSelected_ExtraPremi_Term;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select *,%@.SI_RiderPlan_Desc from %@ %@ join %@ %@ on %@.SI_RiderPlan_ID = %@.ID where SINO = \"%@\"",TABLE_SI_RIDER_PLAN,TABLE_SI_RIDER_SELECTED,TABLE_SI_RIDER_SELECTED,TABLE_SI_RIDER_PLAN,TABLE_SI_RIDER_PLAN,TABLE_SI_RIDER_SELECTED,TABLE_SI_RIDER_PLAN ,SINo]];
    while ([s next]) {
        SINO = [s stringForColumn:@"SINO"];
        SI_RiderPlan_ID = [s intForColumn:@"SI_RiderPlan_ID"];
        SI_RiderPlan_Desc = [s stringForColumn:@"SI_RiderPlan_Desc"];
        SI_RiderSelected_Benefit = [s stringForColumn:@"SI_RiderSelected_Benefit"];
        SI_RiderSelected_COR = [s stringForColumn:@"SI_RiderSelected_COR"];
        SI_RiderSelected_Term = [s stringForColumn:@"SI_RiderSelected_Term"];
        SI_RiderSelected_ExtraPremi_Percent = [s stringForColumn:@"SI_RiderSelected_ExtraPremi_Percent"];
        SI_RiderSelected_ExtraPremi_Mil = [s stringForColumn:@"SI_RiderSelected_ExtraPremi_Mil"];
        SI_RiderSelected_ExtraPremi_Term = [s stringForColumn:@"SI_RiderSelected_ExtraPremi_Term"];
        
        dict=[[NSDictionary alloc]initWithObjectsAndKeys:
              SINO,@"SINO",
              [NSNumber numberWithInt:SI_RiderPlan_ID],@"SI_RiderPlan_ID",
              SI_RiderPlan_Desc,@"SI_RiderPlan_Desc",
              SI_RiderSelected_Benefit,@"SI_RiderSelected_Benefit",
              SI_RiderSelected_COR,@"SI_RiderSelected_COR",
              SI_RiderSelected_Term,@"SI_RiderSelected_Term",
              SI_RiderSelected_ExtraPremi_Percent,@"SI_RiderSelected_ExtraPremi_Percent",
              SI_RiderSelected_ExtraPremi_Mil,@"SI_RiderSelected_ExtraPremi_Mil",
              SI_RiderSelected_ExtraPremi_Term,@"SI_RiderSelected_ExtraPremi_Term",nil];
        
        [arrayRiderSelectedData addObject:dict];
    }
    
    
    [results close];
    [database close];
    return arrayRiderSelectedData;
}

@end
