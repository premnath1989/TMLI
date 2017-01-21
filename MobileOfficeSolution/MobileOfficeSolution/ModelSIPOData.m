//
//  ModelSIPOData.m
//  MPOS
//
//  Created by Basvi on 2/25/16.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ModelSIPOData.h"
#import "String.h"

@implementation ModelSIPOData
bool isPO;

-(void)savePODate:(NSDictionary *)dataPO{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    BOOL success = [database executeUpdate:@"insert into SI_PO_Data (SINO, ProductCode, ProductName, QuickQuote,SIDate,PO_Name,PO_DOB,PO_Gender,PO_Age,PO_OccpCode,PO_Occp,PO_ClientID,RelWithLA, RelWithLAOthers,LA_ClientID,LA_Name,LA_DOB,LA_Age,LA_Gender,LA_OccpCode,LA_Occp,CreatedDate,UpdatedDate,IsInternalStaff) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,""datetime(\"now\", \"+7 hour\")"",""datetime(\"now\", \"+7 hour\")"",?)" ,
                    [dataPO valueForKey:@"SINO"],
                    [dataPO valueForKey:@"ProductCode"],
                    [dataPO valueForKey:@"ProductName"],
                    [dataPO valueForKey:@"QuickQuote"],
                    [dataPO valueForKey:@"SIDate"],
                    [dataPO valueForKey:@"PO_Name"],
                    [dataPO valueForKey:@"PO_DOB"],
                    [dataPO valueForKey:@"PO_Gender"],
                    [dataPO valueForKey:@"PO_Age"],
                    [dataPO valueForKey:@"PO_OccpCode"],
                    [dataPO valueForKey:@"PO_Occp"],
                    [dataPO valueForKey:@"PO_ClientID"],
                    [dataPO valueForKey:@"RelWithLA"],
                    [dataPO valueForKey:@"RelWithLAOthers"],
                    [dataPO valueForKey:@"LA_ClientID"],
                    [dataPO valueForKey:@"LA_Name"],
                    [dataPO valueForKey:@"LA_DOB"],
                    [dataPO valueForKey:@"LA_Age"],
                    [dataPO valueForKey:@"LA_Gender"],
                    [dataPO valueForKey:@"LA_OccpCode"],
                    [dataPO valueForKey:@"LA_Occp"],
                    [dataPO valueForKey:@"IsInternalStaff"]/*,
                    [dataPO valueForKey:@"CreatedDate"],
                    [dataPO valueForKey:@"UpdatedDate"]*/];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
    

}




-(void)updatePOData:(NSDictionary *)dataPO{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path] ;
    [database open];
    BOOL success = [database executeUpdate:@"update SI_PO_Data set ProductCode=?, ProductName=?, QuickQuote=?,SIDate=?,PO_Name=?,PO_DOB=?,PO_Gender=?,PO_Age=?,PO_OccpCode=?,PO_Occp=?,PO_ClientID=?,RelWithLA=?, RelWithLAOthers = ?, LA_ClientID=?,LA_Name=?,LA_DOB=?,LA_Age=?,LA_Gender=?,LA_OccpCode=?,LA_Occp=?,UpdatedDate=""datetime(\"now\", \"+7 hour\")"",IsInternalStaff=? where SINO=?" ,
                    [dataPO valueForKey:@"ProductCode"],
                    [dataPO valueForKey:@"ProductName"],
                    [dataPO valueForKey:@"QuickQuote"],
                    [dataPO valueForKey:@"SIDate"],
                    [dataPO valueForKey:@"PO_Name"],
                    [dataPO valueForKey:@"PO_DOB"],
                    [dataPO valueForKey:@"PO_Gender"],
                    [dataPO valueForKey:@"PO_Age"],
                    [dataPO valueForKey:@"PO_OccpCode"],
                    [dataPO valueForKey:@"PO_Occp"],
                    [dataPO valueForKey:@"PO_ClientID"],
                    [dataPO valueForKey:@"RelWithLA"],
                    [dataPO valueForKey:@"RelWithLAOthers"],
                    [dataPO valueForKey:@"LA_ClientID"],
                    [dataPO valueForKey:@"LA_Name"],
                    [dataPO valueForKey:@"LA_DOB"],
                    [dataPO valueForKey:@"LA_Age"],
                    [dataPO valueForKey:@"LA_Gender"],
                    [dataPO valueForKey:@"LA_OccpCode"],
                    [dataPO valueForKey:@"LA_Occp"],
                    [dataPO valueForKey:@"IsInternalStaff"],
                    [dataPO valueForKey:@"SINO"]];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}

-(void)updatePODataDate:(NSString *)SINO Date:(NSString *)date{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path] ;
    [database open];
    BOOL success = [database executeUpdate:@"update SI_PO_Data set CreatedDate=""datetime(\"now\", \"+7 hour\")"",UpdatedDate=""datetime(\"now\", \"+7 hour\")"",SIDate=? where SINO=?" ,
                    date,SINO];
    //NSLog(@"update SI_PO_Data set SIDate=""select strftime(\"'%@/%m/%Y'\", datetime(\"now\"))"" where SINO=%@",SINO);
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}


-(void)savePartialPODate:(NSDictionary *)dataPO{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    BOOL success = [database executeUpdate:@"insert into SI_PO_Data (SINO, ProductCode, ProductName, QuickQuote,SIDate,PO_Name,PO_DOB,PO_Gender,PO_Age,PO_OccpCode,PO_Occp,PO_ClientID,RelWithLA, RelWithLAOthers, CreatedDate,UpdatedDate,IsInternalStaff) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,""datetime(\"now\", \"+7 hour\")"",""datetime(\"now\", \"+7 hour\")"",?)" ,
                    [dataPO valueForKey:@"SINO"],
                    [dataPO valueForKey:@"ProductCode"],
                    [dataPO valueForKey:@"ProductName"],
                    [dataPO valueForKey:@"QuickQuote"],
                    [dataPO valueForKey:@"SIDate"],
                    [dataPO valueForKey:@"PO_Name"],
                    [dataPO valueForKey:@"PO_DOB"],
                    [dataPO valueForKey:@"PO_Gender"],
                    [dataPO valueForKey:@"PO_Age"],
                    [dataPO valueForKey:@"PO_OccpCode"],
                    [dataPO valueForKey:@"PO_Occp"],
                    [dataPO valueForKey:@"PO_ClientID"],
                    [dataPO valueForKey:@"RelWithLA"],
                    [dataPO valueForKey:@"RelWithLAOthers"],
                    [dataPO valueForKey:@"IsInternalStaff"]
/*,
                                                    [dataPO valueForKey:@"CreatedDate"],
                                                    [dataPO valueForKey:@"UpdatedDate"]*/];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}

-(void)updatePartialPOData:(NSDictionary *)dataPO{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    BOOL success = [database executeUpdate:@"update SI_PO_Data set ProductCode=?, ProductName=?, QuickQuote=?,SIDate=?,PO_Name=?,PO_DOB=?,PO_Gender=?,PO_Age=?,PO_OccpCode=?,PO_Occp=?,PO_ClientID=?,RelWithLA=?,RelWithLAOthers = ?,UpdatedDate=""datetime(\"now\", \"+7 hour\")"",IsInternalStaff=? where SINO=?" ,
                    [dataPO valueForKey:@"ProductCode"],
                    [dataPO valueForKey:@"ProductName"],
                    [dataPO valueForKey:@"QuickQuote"],
                    [dataPO valueForKey:@"SIDate"],
                    [dataPO valueForKey:@"PO_Name"],
                    [dataPO valueForKey:@"PO_DOB"],
                    [dataPO valueForKey:@"PO_Gender"],
                    [dataPO valueForKey:@"PO_Age"],
                    [dataPO valueForKey:@"PO_OccpCode"],
                    [dataPO valueForKey:@"PO_Occp"],
                    [dataPO valueForKey:@"PO_ClientID"],
                    [dataPO valueForKey:@"RelWithLA"],
                    [dataPO valueForKey:@"RelWithLAOthers"],
                    [dataPO valueForKey:@"IsInternalStaff"],
                    [dataPO valueForKey:@"SINO"]];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}


-(void)deletePOData:(NSString *)siNo{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    BOOL success = [database executeUpdate:@"delete from SI_PO_Data where SINO=?",siNo];
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}


-(NSDictionary *)getPO_DataFor:(NSString *)SINo{
    NSDictionary *dict;
    
    NSString* SINO;
    NSString* ProductCode;
    NSString* ProductName;
    NSString* QuickQuote;
    NSString* SIDate;
    NSString* PO_Name;
    NSString* PO_DOB;
    NSString* PO_Gender;
    NSString* PO_Age;
    NSString* PO_OccpCode;
    NSString* PO_Occp;
    NSString* PO_ClientID;
    NSString* RelWithLA;
    NSString* LA_ClientID;
    NSString* LA_Name;
    NSString* LA_DOB;
    NSString* LA_Age;
    NSString* LA_Gender;
    NSString *LA_OccpCode;
    NSString *LA_Occp;
    NSString *CreatedDate;
    NSString *UpdatedDate;
    NSString *IsInternalStaff;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select * from SI_PO_Data where SINO = \"%@\"",SINo]];
    NSLog(@"query %@",[NSString stringWithFormat:@"select * from SI_PO_Data where SINO = \"%@\"",SINo]);
    while ([s next]) {
        SINO = [s stringForColumn:@"SINO"];
        ProductCode = [s stringForColumn:@"ProductCode"];
        ProductName = [s stringForColumn:@"ProductName"];
        QuickQuote = [s stringForColumn:@"QuickQuote"];
        SIDate = [s stringForColumn:@"SIDate"];
        PO_Name = [s stringForColumn:@"PO_Name"];
        PO_DOB = [s stringForColumn:@"PO_DOB"];
        PO_Gender = [s stringForColumn:@"PO_Gender"];
        PO_Age = [s stringForColumn:@"PO_Age"];
        PO_OccpCode = [s stringForColumn:@"PO_OccpCode"];
        PO_Occp = [s stringForColumn:@"PO_Occp"];
        PO_ClientID = [s stringForColumn:@"PO_ClientID"];
        RelWithLA = [s stringForColumn:@"RelWithLA"];
        LA_ClientID = [s stringForColumn:@"LA_ClientID"];
        LA_Name = [s stringForColumn:@"LA_Name"];
        LA_DOB = [s stringForColumn:@"LA_DOB"];
        LA_Age = [s stringForColumn:@"LA_Age"];
        LA_Gender = [s stringForColumn:@"LA_Gender"];
        LA_OccpCode = [s stringForColumn:@"LA_OccpCode"];
        LA_Occp = [s stringForColumn:@"LA_Occp"];
        CreatedDate = [s stringForColumn:@"CreatedDate"];
        UpdatedDate = [s stringForColumn:@"UpdatedDate"];
        IsInternalStaff = [s stringForColumn:@"IsInternalStaff"];
    }

    dict=[[NSDictionary alloc]initWithObjectsAndKeys:
                                          SINO,@"SINO",
                                          ProductCode,@"ProductCode",
                                          ProductName,@"ProductName",
                                          QuickQuote,@"QuickQuote",
                                          SIDate,@"SIDate",
                                          PO_Name,@"PO_Name",
                                          PO_DOB,@"PO_DOB",
                                          PO_Gender,@"PO_Gender",
                                          PO_Age,@"PO_Age",
                                          PO_OccpCode,@"PO_OccpCode",
                                          PO_Occp,@"PO_Occp",
                                          PO_ClientID,@"PO_ClientID",
                                          RelWithLA,@"RelWithLA",
                                          LA_ClientID,@"LA_ClientID",
                                          LA_Name,@"LA_Name",
                                          LA_DOB,@"LA_DOB",
                                          LA_Age,@"LA_Age",
                                          LA_Gender,@"LA_Gender",
                                          LA_OccpCode,@"LA_OccpCode",
                                          LA_Occp,@"LA_Occp",
                                          CreatedDate,@"CreatedDate",
                                          UpdatedDate,@"UpdatedDate",
                                          IsInternalStaff,@"IsInternalStaff",nil];
    
   [results close];
   [database close];
   return dict;
}

-(int)getPODataCount:(NSString *)SINo{
    int count;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select count(*) from SI_PO_Data where SINO = \"%@\"",SINo]];
    while ([s next]) {
        count = [s intForColumn:@"count(*)"];
    }
    
    [results close];
    [database close];
    return count;
}

-(int)getLADataCount:(NSString *)prospectProfileID{
    int count;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select count(*) from SI_PO_Data where LA_ClientID = \"%@\" or PO_ClientID = \"%@\"",prospectProfileID,prospectProfileID]];
    while ([s next]) {
        count = [s intForColumn:@"count(*)"];
    }
    
    [results close];
    [database close];
    return count;
}

-(NSMutableArray *)getSINumberForProspectProfileID:(NSString *)prospectProfileID{
    NSMutableArray *SINumberArray = [[NSMutableArray alloc]init];
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select SINO from SI_PO_Data where LA_ClientID = \"%@\" or PO_ClientID = \"%@\"",prospectProfileID,prospectProfileID]];
    while ([s next]) {
        [SINumberArray addObject:[s stringForColumn:@"SINO"]];
    }
    
    [results close];
    [database close];
    return SINumberArray;
}

#pragma mark unit linked methods

-(void)savePOLAData:(NSMutableDictionary *)dictPOLAData{
    //cek the SINO exist or not
    int exist = [self getPODataCount:[dictPOLAData valueForKey:@"SINO"]];
    
    if (exist>0){
        //update data
        [self updatePOLAData:dictPOLAData];
    }
    else{
        //insert data
        [self insertToDBPOLAData:dictPOLAData];
    }
}

-(void)insertToDBPOLAData:(NSMutableDictionary *)dictPOLAData{
    
    int clientID;
    NSNumber *tt = [dictPOLAData valueForKey:@"QuickQuote"];
    if ([tt intValue] == 1) {
        isPO = YES;
        clientID = [self savePOToProspect:dictPOLAData];
        [dictPOLAData setObject:[NSNumber numberWithInt:clientID] forKey:@"PO_ClientID"];
    }
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    //BOOL success = [database executeUpdate:@"insert into SI_PO_Data (SINO, ProductCode, ProductName, QuickQuote,SIDate,PO_Name,PO_DOB,PO_Gender,PO_Age,PO_OccpCode,PO_Occp,PO_ClientID,RelWithLA,LA_ClientID,LA_Name,LA_DOB,LA_Age,LA_Gender,LA_OccpCode,LA_Occp,CreatedDate,UpdatedDate,IsInternalStaff,PO_Smoker,PO_CommencementDate,PO_MonthlyIncome,LA_Smoker,LA_CommencementDate,LA_MonthlyIncome) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,""datetime(\"now\", \"+7 hour\")"",""datetime(\"now\", \"+7 hour\")"",?,?,?,?,?,?,?)" ,
    BOOL success = [database executeUpdate:@"insert into SI_PO_Data (SINO, ProductCode, ProductName, QuickQuote,SIDate,PO_Name,PO_DOB,PO_Gender,PO_Age,PO_OccpCode,PO_Occp,PO_ClientID,RelWithLA,RelWithLAOthers,LA_ClientID,LA_Name,LA_DOB,LA_Age,LA_Gender,LA_OccpCode,LA_Occp,CreatedDate,UpdatedDate,IsInternalStaff) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,""datetime(\"now\", \"+7 hour\")"",""datetime(\"now\", \"+7 hour\")"",?)" ,
                    [dictPOLAData valueForKey:@"SINO"],
                    [dictPOLAData valueForKey:@"ProductCode"],
                    [dictPOLAData valueForKey:@"ProductName"],
                    [dictPOLAData valueForKey:@"QuickQuote"],
                    [dictPOLAData valueForKey:@"SIDate"],
                    [dictPOLAData valueForKey:@"PO_Name"],
                    [dictPOLAData valueForKey:@"PO_DOB"],
                    [dictPOLAData valueForKey:@"PO_Gender"],
                    [dictPOLAData valueForKey:@"PO_Age"],
                    [dictPOLAData valueForKey:@"PO_OccpCode"],
                    [dictPOLAData valueForKey:@"PO_Occp"],
                    [dictPOLAData valueForKey:@"PO_ClientID"],
                    [dictPOLAData valueForKey:@"RelWithLA"],
                    [dictPOLAData valueForKey:@"RelWithLAOthers"],
                    [dictPOLAData valueForKey:@"LA_ClientID"],
                    [dictPOLAData valueForKey:@"LA_Name"],
                    [dictPOLAData valueForKey:@"LA_DOB"],
                    [dictPOLAData valueForKey:@"LA_Age"],
                    [dictPOLAData valueForKey:@"LA_Gender"],
                    [dictPOLAData valueForKey:@"LA_OccpCode"],
                    [dictPOLAData valueForKey:@"LA_Occp"],
                    [dictPOLAData valueForKey:@"IsInternalStaff"]];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
    

}

-(int)savePOToProspect:(NSDictionary *)dictPOLAData{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    NSString *score = [self calculateScore:dictPOLAData];
    int LastID = 0;
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    BOOL success = [database executeUpdate:@"insert into prospect_profile (\'ProspectName\', \'ProspectLastName\', \"ProspectDOB\",\"ProspectGender\",  \"ProspectStatus\", \"Score\", \"ProspectAge\", \"QQFlag\", \"DateCreated\", \"DateModified\") values (?,?,?,?,?,?,?,?,""datetime(\"now\", \"+7 hour\")"",""datetime(\"now\", \"+7 hour\")"")",
                    [dictPOLAData valueForKey:@"PO_Name"],
                    @"",
                    [dictPOLAData valueForKey:@"PO_DOB"],
                    [dictPOLAData valueForKey:@"PO_Gender"],
                    @"Incomplete",
                    score,
                    [dictPOLAData valueForKey:@"PO_Age"],
                    @"false"
                    ];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    else {
         NSString *GetLastIdSQL = [NSString stringWithFormat:@"Select indexno  from prospect_profile order by \"indexNo\" desc limit 1"];
        FMResultSet *s = [database executeQuery:GetLastIdSQL];

        while ([s next]) {
            LastID = [[s stringForColumn:@"indexno"] intValue];
        }
        
    }
    [results close];
    [database close];
    
    return LastID;
}

-(int)saveLAToProspect:(NSDictionary *)dictPOLAData{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    NSString *score = [self calculateScore:dictPOLAData];
    int LastID = 0;
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    BOOL success = [database executeUpdate:@"insert into prospect_profile (\'ProspectName\', \'ProspectLastName\', \"ProspectDOB\",\"ProspectGender\",  \"ProspectStatus\", \"Score\", \"ProspectAge\", \"QQFlag\", \"DateCreated\", \"DateModified\") values (?,?,?,?,?,?,?,?,""datetime(\"now\", \"+7 hour\")"",""datetime(\"now\", \"+7 hour\")"")",
                    [dictPOLAData valueForKey:@"LA_Name"],
                    @"",
                    [dictPOLAData valueForKey:@"LA_DOB"],
                    [dictPOLAData valueForKey:@"LA_Gender"],
                    @"Incomplete",
                    score,
                    [dictPOLAData valueForKey:@"LA_Age"],
                    @"false"
                    ];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    else {
        NSString *GetLastIdSQL = [NSString stringWithFormat:@"Select indexno  from prospect_profile order by \"indexNo\" desc limit 1"];
        FMResultSet *s = [database executeQuery:GetLastIdSQL];
        
        while ([s next]) {
            LastID = [[s stringForColumn:@"indexno"] intValue];
        }
        
    }
    [results close];
    [database close];
    
    return LastID;
}


-(NSString*) calculateScore :(NSDictionary *)dictPOLAData{
    
    int intPoin = 0;
    int intAge = 0;
    NSString *stringInputValue;
    NSString *gender;
    
    if (isPO) {
        gender = [dictPOLAData valueForKey:@"PO_Gender"];
        intAge = [[dictPOLAData valueForKey:@"PO_Age"] intValue];
    }
    else {
        gender = [dictPOLAData valueForKey:@"LA_Gender"];
        intAge = [[dictPOLAData valueForKey:@"LA_Age"] intValue];
    }
    
    int score;
    
    //status: prospect lama, automatic got 2
    score = 2;
    
    
    //Gender Point
    if ([gender isEqualToString:@"MALE"]) {
        score += 2;
    }
    else {
        score += 1;
    }
    
    //Age
    
    
    if (intAge > 35 && intAge < 46)
    {
        intPoin = 5;
        stringInputValue = @"35 < age < 45";
    }
    else if (intAge >45 && intAge < 56)
    {
        intPoin = 4;
        stringInputValue = @"45 < age < 56";
    }
    else if (intAge > 55)
    {
        intPoin =  3;
        stringInputValue = @"35 < age < 45";
    }
    else if (intAge > 25 && intAge < 36)
    {
        intPoin = 2;
        stringInputValue = @"25 < age < 36";
    }
    else if (intAge > 16 && intAge < 26)
    {
        intPoin = 1;
        stringInputValue = @"17 < age < 26";
    }
    
    
    /* RESULT */
    
    score += intPoin;
    NSLog(@"Calculate Score - Age | name -> %@, point -> %d, accumulate point -> %d", stringInputValue, intPoin, score);
    
    NSString *rScore = [NSString stringWithFormat:@"%d", score];
    
    return rScore;
}

-(void)updatePOLAData:(NSMutableDictionary *)dictPOLAData{
    
    int clientID;
    if ([[dictPOLAData valueForKey:@"LA_ClientID"] intValue] == 0) {
        isPO = NO;
        clientID = [self saveLAToProspect:dictPOLAData];
        [dictPOLAData setObject:[NSNumber numberWithInt:clientID] forKey:@"LA_ClientID"];
    }
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path] ;
    [database open];
    //BOOL success = [database executeUpdate:@"update SI_PO_Data set ProductCode=?, ProductName=?, QuickQuote=?,SIDate=?,PO_Name=?,PO_DOB=?,PO_Gender=?,PO_Age=?,PO_OccpCode=?,PO_Occp=?,PO_ClientID=?,RelWithLA=?,LA_ClientID=?,LA_Name=?,LA_DOB=?,LA_Age=?,LA_Gender=?,LA_OccpCode=?,LA_Occp=?,UpdatedDate=""datetime(\"now\", \"+7 hour\")"",IsInternalStaff=?,PO_Smoker=?,PO_CommencementDate=?,PO_MonthlyIncome=?,LA_Smoker=?,LA_CommencementDate=?,LA_MonthlyIncome=? where SINO=?" ,
    BOOL success = [database executeUpdate:@"update SI_PO_Data set ProductCode=?, ProductName=?, QuickQuote=?,SIDate=?,PO_Name=?,PO_DOB=?,PO_Gender=?,PO_Age=?,PO_OccpCode=?,PO_Occp=?,PO_ClientID=?,RelWithLA=?,RelWithLAOthers = ?, LA_ClientID=?,LA_Name=?,LA_DOB=?,LA_Age=?,LA_Gender=?,LA_OccpCode=?,LA_Occp=?,UpdatedDate=""datetime(\"now\", \"+7 hour\")"",IsInternalStaff=? where SINO=?" ,
                    [dictPOLAData valueForKey:@"ProductCode"],
                    [dictPOLAData valueForKey:@"ProductName"],
                    [dictPOLAData valueForKey:@"QuickQuote"],
                    [dictPOLAData valueForKey:@"SIDate"],
                    [dictPOLAData valueForKey:@"PO_Name"],
                    [dictPOLAData valueForKey:@"PO_DOB"],
                    [dictPOLAData valueForKey:@"PO_Gender"],
                    [dictPOLAData valueForKey:@"PO_Age"],
                    [dictPOLAData valueForKey:@"PO_OccpCode"],
                    [dictPOLAData valueForKey:@"PO_Occp"],
                    [dictPOLAData valueForKey:@"PO_ClientID"],
                    [dictPOLAData valueForKey:@"RelWithLA"],
                    [dictPOLAData valueForKey:@"RelWithLAOthers"],
                    [dictPOLAData valueForKey:@"LA_ClientID"],
                    [dictPOLAData valueForKey:@"LA_Name"],
                    [dictPOLAData valueForKey:@"LA_DOB"],
                    [dictPOLAData valueForKey:@"LA_Age"],
                    [dictPOLAData valueForKey:@"LA_Gender"],
                    [dictPOLAData valueForKey:@"LA_OccpCode"],
                    [dictPOLAData valueForKey:@"LA_Occp"],
                    [dictPOLAData valueForKey:@"IsInternalStaff"],
                    [dictPOLAData valueForKey:@"SINO"]];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}

-(NSDictionary *)getPOLADataFor:(NSString *)SINo{
    NSDictionary *dict;
    
    NSString* SINO;
    NSString* ProductCode;
    NSString* ProductName;
    NSString* QuickQuote;
    NSString* SIDate;
    NSString* PO_Name;
    NSString* PO_DOB;
    NSString* PO_Gender;
    NSString* PO_Age;
    NSString* PO_OccpCode;
    NSString* PO_Occp;
    NSString* PO_ClientID;
    NSString* RelWithLA;
    NSString* RelWithLAOthers;
    NSString* LA_ClientID;
    NSString* LA_Name;
    NSString* LA_DOB;
    NSString* LA_Age;
    NSString* LA_Gender;
    NSString *LA_OccpCode;
    NSString *LA_Occp;
    NSString *CreatedDate;
    NSString *UpdatedDate;
    NSString *IsInternalStaff;
    NSString *PO_Smoker;
    NSString *PO_CommencementDate;
    NSString *PO_MonthlyIncome;
    NSString *LA_Smoker;
    NSString *LA_CommencementDate;
    NSString *LA_MonthlyIncome;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select * from SI_PO_Data where SINO = \"%@\"",SINo]];
    NSLog(@"query %@",[NSString stringWithFormat:@"select * from SI_PO_Data where SINO = \"%@\"",SINo]);
    while ([s next]) {
        SINO = [s stringForColumn:@"SINO"]?:@"";
        ProductCode = [s stringForColumn:@"ProductCode"]?:@"";
        ProductName = [s stringForColumn:@"ProductName"]?:@"";
        QuickQuote = [s stringForColumn:@"QuickQuote"]?:@"";
        SIDate = [s stringForColumn:@"SIDate"]?:@"";
        PO_Name = [s stringForColumn:@"PO_Name"]?:@"";
        PO_DOB = [s stringForColumn:@"PO_DOB"]?:@"";
        PO_Gender = [s stringForColumn:@"PO_Gender"]?:@"";
        PO_Age = [s stringForColumn:@"PO_Age"]?:@"";
        PO_OccpCode = [s stringForColumn:@"PO_OccpCode"]?:@"";
        PO_Occp = [s stringForColumn:@"PO_Occp"]?:@"";
        PO_ClientID = [s stringForColumn:@"PO_ClientID"]?:@"";
        RelWithLA = [s stringForColumn:@"RelWithLA"]?:@"";
        RelWithLAOthers = [s stringForColumn:@"RelWithLAOthers"]?:@"";
        LA_ClientID = [s stringForColumn:@"LA_ClientID"]?:@"";
        LA_Name = [s stringForColumn:@"LA_Name"]?:@"";
        LA_DOB = [s stringForColumn:@"LA_DOB"]?:@"";
        LA_Age = [s stringForColumn:@"LA_Age"]?:@"";
        LA_Gender = [s stringForColumn:@"LA_Gender"]?:@"";
        LA_OccpCode = [s stringForColumn:@"LA_OccpCode"]?:@"";
        LA_Occp = [s stringForColumn:@"LA_Occp"]?:@"";
        CreatedDate = [s stringForColumn:@"CreatedDate"]?:@"";
        UpdatedDate = [s stringForColumn:@"UpdatedDate"]?:@"";
        IsInternalStaff = [s stringForColumn:@"IsInternalStaff"]?:@"";
        PO_Smoker = [s stringForColumn:@"PO_Smoker"]?:@"";
        PO_CommencementDate = [s stringForColumn:@"PO_CommencementDate"]?:@"";
        PO_MonthlyIncome = [s stringForColumn:@"PO_MonthlyIncome"]?:@"";
        LA_Smoker = [s stringForColumn:@"LA_Smoker"]?:@"";
        LA_CommencementDate = [s stringForColumn:@"LA_CommencementDate"]?:@"";
        LA_MonthlyIncome = [s stringForColumn:@"LA_MonthlyIncome"]?:@"";
    }
    
    dict=[[NSDictionary alloc]initWithObjectsAndKeys:
          SINO,@"SINO",
          ProductCode,@"ProductCode",
          ProductName,@"ProductName",
          QuickQuote,@"QuickQuote",
          SIDate,@"SIDate",
          PO_Name,@"PO_Name",
          PO_DOB,@"PO_DOB",
          PO_Gender,@"PO_Gender",
          PO_Age,@"PO_Age",
          PO_OccpCode,@"PO_OccpCode",
          PO_Occp,@"PO_Occp",
          PO_ClientID,@"PO_ClientID",
          RelWithLA,@"RelWithLA",
          RelWithLAOthers,@"RelWithLAOthers",
          LA_ClientID,@"LA_ClientID",
          LA_Name,@"LA_Name",
          LA_DOB,@"LA_DOB",
          LA_Age,@"LA_Age",
          LA_Gender,@"LA_Gender",
          LA_OccpCode,@"LA_OccpCode",
          LA_Occp,@"LA_Occp",
          CreatedDate,@"CreatedDate",
          UpdatedDate,@"UpdatedDate",
          IsInternalStaff,@"IsInternalStaff",
          PO_Smoker?:@"",@"PO_Smoker",
          PO_CommencementDate?:@"",@"PO_CommencementDate",
          PO_MonthlyIncome?:@"",@"PO_MonthlyIncome",
          LA_Smoker?:@"",@"LA_Smoker",
          LA_CommencementDate?:@"",@"LA_CommencementDate",
          LA_MonthlyIncome?:@"",@"LA_MonthlyIncome",nil];
    
    [results close];
    [database close];
    return dict;
}
@end
