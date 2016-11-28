//
//  ModelPopover.m
//  MPOS
//
//  Created by Basvi on 2/4/16.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ModelPopover.h"
#import "String.h"

@implementation ModelPopover
-(NSDictionary *)getSourceIncome{
    NSDictionary *dict;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSMutableArray* arraySourceCode=[[NSMutableArray alloc] init];
    NSMutableArray* arraySourceDesc=[[NSMutableArray alloc] init];
    NSMutableArray* arrayStatus=[[NSMutableArray alloc] init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE status = 'A'", TABLE_SOURCEINCOME];
    FMResultSet *s = [database executeQuery:query];
    while ([s next]) {
        NSString *SourceCode = [NSString stringWithFormat:@"%@",[s stringForColumn:@"SourceCode"]];
        NSString *SourceDesc = [NSString stringWithFormat:@"%@",[s stringForColumn:@"SourceDesc"]];
        NSString *Status = [NSString stringWithFormat:@"%@",[s stringForColumn:@"Status"]];
        
        [arraySourceCode addObject:SourceCode];
        [arraySourceDesc addObject:SourceDesc];
        [arrayStatus addObject:Status];
    }
    dict = [[NSDictionary alloc] initWithObjectsAndKeys:arraySourceCode,@"SourceCode", arraySourceDesc,@"SourceDesc",arrayStatus,@"Status",nil];
    
    [results close];
    [database close];
    return dict;
}

-(NSDictionary *)getAnnualIncome{
    NSDictionary *dict;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSMutableArray* arraySourceCode=[[NSMutableArray alloc] init];
    NSMutableArray* arraySourceDesc=[[NSMutableArray alloc] init];
    NSMutableArray* arrayStatus=[[NSMutableArray alloc] init];
    
    FMResultSet *s = [database executeQuery:@"SELECT * FROM eProposal_AnnualIncome WHERE status = 'A'"];
    while ([s next]) {
        NSString *AnnCode = [NSString stringWithFormat:@"%@",[s stringForColumn:@"AnnCode"]];
        NSString *AnnDesc = [NSString stringWithFormat:@"%@",[s stringForColumn:@"AnnDesc"]];
        NSString *Status = [NSString stringWithFormat:@"%@",[s stringForColumn:@"Status"]];
        
        [arraySourceCode addObject:AnnCode];
        [arraySourceDesc addObject:AnnDesc];
        [arrayStatus addObject:Status];
    }
    dict = [[NSDictionary alloc] initWithObjectsAndKeys:arraySourceCode,@"AnnCode", arraySourceDesc,@"AnnDesc",arrayStatus,@"Status",nil];
    
    [results close];
    [database close];
    return dict;
}

-(NSDictionary *)getVIPClass{
    NSDictionary *dict;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSMutableArray* arrayVIPCode=[[NSMutableArray alloc] init];
    NSMutableArray* arrayVIPDesc=[[NSMutableArray alloc] init];
    NSMutableArray* arrayStatus=[[NSMutableArray alloc] init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE status = 'A'", TABLE_VIPCLASS];
    FMResultSet *s = [database executeQuery:query];
    while ([s next]) {
        NSString *vipCode = [NSString stringWithFormat:@"%@",[s stringForColumn:@"VIPCode"]];
        NSString *vipDesc = [NSString stringWithFormat:@"%@",[s stringForColumn:@"VIPDesc"]];
        NSString *Status = [NSString stringWithFormat:@"%@",[s stringForColumn:@"Status"]];
        
        [arrayVIPCode addObject:vipCode];
        [arrayVIPDesc addObject:vipDesc];
        [arrayStatus addObject:Status];
    }
    dict = [[NSDictionary alloc] initWithObjectsAndKeys:arrayVIPCode,@"VIPCode", arrayVIPDesc,@"VIPDesc",arrayStatus,@"Status",nil];
    
    [results close];
    [database close];
    return dict;
}

-(NSDictionary *)getReferralSource{
    NSDictionary *dict;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSMutableArray* arrayReferCode=[[NSMutableArray alloc] init];
    NSMutableArray* arrayReferDesc=[[NSMutableArray alloc] init];
    NSMutableArray* arrayStatus=[[NSMutableArray alloc] init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE status = 'A'", TABLE_REFERRALSOURCE];
    FMResultSet *s = [database executeQuery:query];
    while ([s next]) {
        NSString *referCode = [NSString stringWithFormat:@"%@",[s stringForColumn:@"ReferCode"]];
        NSString *referDesc = [NSString stringWithFormat:@"%@",[s stringForColumn:@"ReferDesc"]];
        NSString *Status = [NSString stringWithFormat:@"%@",[s stringForColumn:@"Status"]];
        
        [arrayReferCode addObject:referCode];
        [arrayReferDesc addObject:referDesc];
        [arrayStatus addObject:Status];
    }
    dict = [[NSDictionary alloc] initWithObjectsAndKeys:arrayReferCode,@"ReferCode", arrayReferDesc,@"ReferDesc",arrayStatus,@"Status",nil];
    
    [results close];
    [database close];
    return dict;
}

-(NSDictionary *)getTitle{
    NSDictionary *dict;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSMutableArray* arrayTitleCode=[[NSMutableArray alloc] init];
    NSMutableArray* arrayTitleDesc=[[NSMutableArray alloc] init];
    NSMutableArray* arrayStatus=[[NSMutableArray alloc] init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE status = 'A'",TABLE_TITLE];
    FMResultSet *s = [database executeQuery:query];
    while ([s next]) {
        NSString *titleCode = [NSString stringWithFormat:@"%@",[s stringForColumn:@"TitleCode"]];
        NSString *titleDesc = [NSString stringWithFormat:@"%@",[s stringForColumn:@"TitleDesc"]];
        NSString *Status = [NSString stringWithFormat:@"%@",[s stringForColumn:@"Status"]];
        
        [arrayTitleCode addObject:titleCode];
        [arrayTitleDesc addObject:titleDesc];
        [arrayStatus addObject:Status];
    }
    dict = [[NSDictionary alloc] initWithObjectsAndKeys:arrayTitleCode,@"TitleCode", arrayTitleDesc,@"TitleDesc",arrayStatus,@"Status",nil];
    
    [results close];
    [database close];
    return dict;
}

-(NSDictionary *)getOccupation{
    NSDictionary *dict;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSMutableArray* arrayOccpCode=[[NSMutableArray alloc] init];
    NSMutableArray* arrayOccpDesc=[[NSMutableArray alloc] init];
    NSMutableArray* arrayOccpClass=[[NSMutableArray alloc] init];
    NSMutableArray* arrayStatus=[[NSMutableArray alloc] init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE status = 'A'", TABLE_OCCP];
    FMResultSet *s = [database executeQuery:query];
    while ([s next]) {
        NSString *occpCode = [NSString stringWithFormat:@"%@",[s stringForColumn:@"occp_Code"]];
        NSString *occpeDesc = [NSString stringWithFormat:@"%@",[s stringForColumn:@"OccpDesc"]];
        NSString *occpClass = [NSString stringWithFormat:@"%@",[s stringForColumn:@"OccpClass"]];
        NSString *Status = [NSString stringWithFormat:@"%@",[s stringForColumn:@"Status"]];
        
        [arrayOccpCode addObject:occpCode];
        [arrayOccpDesc addObject:occpeDesc];
        [arrayOccpClass addObject:occpClass];
        [arrayStatus addObject:Status];
    }
    dict = [[NSDictionary alloc] initWithObjectsAndKeys:arrayOccpCode,@"OccpCode", arrayOccpDesc,@"OccpDesc", arrayOccpClass,@"occpClass",arrayStatus,@"Status",nil];
    
    [results close];
    [database close];
    return dict;
}

-(NSDictionary *)getOccupationByCode:(NSString *)occupCode{
    NSDictionary *dict;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSString* stringOccpCode=[[NSString alloc] init];
    NSString* stringOccpDesc=[[NSString alloc] init];
    NSString* stringOccpClass=[[NSString alloc] init];
    NSString* stringStatus=[[NSString alloc] init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ where occp_Code = \"%@\"",TABLE_OCCP,occupCode];
    FMResultSet *s = [database executeQuery:query];
    while ([s next]) {
        stringOccpCode = [NSString stringWithFormat:@"%@",[s stringForColumn:@"occp_Code"]];
        stringOccpDesc = [NSString stringWithFormat:@"%@",[s stringForColumn:@"OccpDesc"]];
        stringOccpClass = [NSString stringWithFormat:@"%@",[s stringForColumn:@"OccpClass"]];
        stringStatus = [NSString stringWithFormat:@"%@",[s stringForColumn:@"Status"]];
    }
    dict = [[NSDictionary alloc] initWithObjectsAndKeys:stringOccpCode,@"OccpCode", stringOccpDesc,@"OccpDesc", stringOccpClass,@"occpClass",stringStatus,@"Status",nil];
    
    [results close];
    [database close];
    return dict;
}


-(NSDictionary *)getBranchInfo:(NSString *)columnOrder{
    NSDictionary *dict;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSMutableArray* arrayKodeCabang=[[NSMutableArray alloc] init];
    NSMutableArray* arrayNamaCabang=[[NSMutableArray alloc] init];
    NSMutableArray* arrayStatusCabang=[[NSMutableArray alloc] init];
    NSMutableArray* arrayKanwilCabang=[[NSMutableArray alloc] init];
    NSMutableArray* arrayStatus=[[NSMutableArray alloc] init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT dc.* FROM %@ dc, %@ ap WHERE dc.status = 'A' and ap.Kanwil = dc.Kanwil order by %@ ASC",TABLE_DATA_CABANG,TABLE_AGENT_PROFILE, columnOrder];
    
    FMResultSet *s = [database executeQuery:query];
    
   NSLog(@"query %@",[NSString stringWithFormat:@"SELECT dc.* FROM %@ dc, %@ ap WHERE dc.status = 'A' and ap.Kanwil = dc.Kanwil order by %@ ASC",TABLE_DATA_CABANG,TABLE_AGENT_PROFILE, columnOrder]);
    while ([s next]) {
        NSString *occpCode = [NSString stringWithFormat:@"%@",[s stringForColumn:@"KodeCabang"]];
        NSString *occpeDesc = [NSString stringWithFormat:@"%@",[s stringForColumn:@"NamaCabang"]];
        NSString *occpClass = [NSString stringWithFormat:@"%@ - %@",[s stringForColumn:@"KodeCabangInduk"],[s stringForColumn:@"NamaCabangInduk"]];
        NSString *stringKanwil = [NSString stringWithFormat:@"%@ - %@",[s stringForColumn:@"Wilayah"],[s stringForColumn:@"Kanwil"]];

        NSString *Status = [NSString stringWithFormat:@"%@",[s stringForColumn:@"Status"]];
        
        [arrayKodeCabang addObject:occpCode];
        [arrayNamaCabang addObject:occpeDesc];
        [arrayStatusCabang addObject:occpClass];
        [arrayKanwilCabang addObject:stringKanwil];
        [arrayStatus addObject:Status];
    }
    dict = [[NSDictionary alloc] initWithObjectsAndKeys:arrayKodeCabang,@"KodeCabang", arrayNamaCabang,@"NamaCabang", arrayStatusCabang,@"StatusCabang",arrayKanwilCabang,@"KanwilCabang",arrayStatus,@"Status",nil];
    
    [results close];
    [database close];
    return dict;
}

-(NSDictionary *)getBranchInfoFilter:(NSString *)columnFilter ColumnValue:(NSString *)columnValue{
    NSDictionary *dict;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSString *branchCode;
    NSString *branchName;
    NSString *branchParent;
    NSString *branchKanwil;
    NSString *Status;
    
    //FMResultSet *s = [database executeQuery:@"SELECT dc.* FROM Data_Cabang dc, Agent_profile ap WHERE dc.status = 'A' and ap.Kanwil = dc.Kanwil and %@ = \"%@\"",columnFilter,columnValue];
    
    FMResultSet *s;
    if ([columnFilter isEqualToString:@"dc.KodeCabang"]){
        NSString *query = [NSString stringWithFormat:@"SELECT dc.* FROM %@ dc, %@ ap WHERE dc.status = 'A' and ap.Kanwil = dc.Kanwil and dc.KodeCabang=%@", TABLE_DATA_CABANG, TABLE_AGENT_PROFILE,columnValue];
        s = [database executeQuery:query];
    }
    else{
        NSString *query = [NSString stringWithFormat:@"SELECT dc.* FROM %@ dc, %@ ap WHERE dc.status = 'A' and ap.Kanwil = dc.Kanwil and dc.NamaCabang=%@", TABLE_DATA_CABANG, TABLE_AGENT_PROFILE,columnValue];
        s = [database executeQuery:query];
    }
    while ([s next]) {
        branchCode = [NSString stringWithFormat:@"%@",[s stringForColumn:@"KodeCabang"]];
        branchName = [NSString stringWithFormat:@"%@",[s stringForColumn:@"NamaCabang"]];
        branchParent = [NSString stringWithFormat:@"%@ - %@",[s stringForColumn:@"KodeCabangInduk"],[s stringForColumn:@"NamaCabangInduk"]];
        branchKanwil = [NSString stringWithFormat:@"%@ - %@",[s stringForColumn:@"Wilayah"],[s stringForColumn:@"Kanwil"]];
        Status = [NSString stringWithFormat:@"%@",[s stringForColumn:@"Status"]];
    }
    dict = [[NSDictionary alloc] initWithObjectsAndKeys:branchCode,@"KodeCabang", branchName,@"NamaCabang", branchParent,@"StatusCabang",branchKanwil,@"KanwilCabang",Status,@"Status",nil];
    
    [results close];
    [database close];
    return dict;
}



@end
