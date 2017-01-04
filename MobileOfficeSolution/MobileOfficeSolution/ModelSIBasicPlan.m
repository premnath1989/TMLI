//
//  ModelSIBasicPlan.m
//  BLESS
//
//  Created by Basvi on 11/15/16.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ModelSIBasicPlan.h"
#import "Model_SI_Master.h"
@implementation ModelSIBasicPlan
#pragma mark unit linked methods

-(int)getBasicPlanDataCount:(NSString *)SINo{
    int count;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select count(*) from SI_BasicPlan where SINO = \"%@\"",SINo]];
    while ([s next]) {
        count = [s intForColumn:@"count(*)"];
    }
    
    [results close];
    [database close];
    return count;
}

-(void)saveBasicPlanData:(NSMutableDictionary *)dictBasicPlanData{
    modelSIMaster = [[Model_SI_Master alloc]init];
    //cek the SINO exist or not
    int exist = [self getBasicPlanDataCount:[dictBasicPlanData valueForKey:@"SINO"]];
    
    if (exist>0){
        //update data
        [self updateBasicPlanData:dictBasicPlanData];
    }
    else{
        //insert data
        [self insertToDBBasicPlanData:dictBasicPlanData];
    }
    //[modelSIMaster updateIlustrationSumAssured:[dictBasicPlanData valueForKey:@"SumAssured"] SINO:[dictBasicPlanData valueForKey:@"SINO"]];
}

-(void)insertToDBBasicPlanData:(NSMutableDictionary *)dictBasicPlanData{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    BOOL success = [database executeUpdate:@"insert into SI_BasicPlan (SINO, PaymentMode, PreferredPremium, RegularTopUp,Premium,SumAssured,PremiumHolidayTerm,TotalUnAppliedPremium,TargetValue,ExtraPremiumPercentage,ExtraPremiumMil,ExtraPremiumTerm,Payment_Term,Payment_Frequency,PaymentCurrency,TotalPremium) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    [dictBasicPlanData valueForKey:@"SINO"],
                    [dictBasicPlanData valueForKey:@"PaymentMode"],
                    [dictBasicPlanData valueForKey:@"PreferredPremium"],
                    [dictBasicPlanData valueForKey:@"RegularTopUp"],
                    [dictBasicPlanData valueForKey:@"Premium"],
                    [dictBasicPlanData valueForKey:@"SumAssured"],
                    [dictBasicPlanData valueForKey:@"PremiumHolidayTerm"],
                    [dictBasicPlanData valueForKey:@"TotalUnAppliedPremium"],
                    [dictBasicPlanData valueForKey:@"TargetValue"],
                    [dictBasicPlanData valueForKey:@"ExtraPremiumPercentage"],
                    [dictBasicPlanData valueForKey:@"ExtraPremiumMil"],
                    [dictBasicPlanData valueForKey:@"ExtraPremiumTerm"],
                    [dictBasicPlanData valueForKey:@"Payment_Term"],
                    [dictBasicPlanData valueForKey:@"Payment_Frequency"],
                    [dictBasicPlanData valueForKey:@"PaymentCurrency"],
                    [dictBasicPlanData valueForKey:@"TotalPremium"]];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}

-(void)updateBasicPlanData:(NSMutableDictionary *)dictBasicPlanData{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path] ;
    [database open];
    BOOL success = [database executeUpdate:@"update SI_BasicPlan set PaymentMode=?, PreferredPremium=?, RegularTopUp=?,Premium=?,SumAssured=?,PremiumHolidayTerm=?,TotalUnAppliedPremium=?,TargetValue=?,ExtraPremiumPercentage=?,ExtraPremiumMil=?,ExtraPremiumTerm=?,Payment_Term=?,Payment_Frequency=?,PaymentCurrency=?,TotalPremium=? where SINO=?" ,
                    [dictBasicPlanData valueForKey:@"PaymentMode"],
                    [dictBasicPlanData valueForKey:@"PreferredPremium"],
                    [dictBasicPlanData valueForKey:@"RegularTopUp"],
                    [dictBasicPlanData valueForKey:@"Premium"],
                    [dictBasicPlanData valueForKey:@"SumAssured"],
                    [dictBasicPlanData valueForKey:@"PremiumHolidayTerm"],
                    [dictBasicPlanData valueForKey:@"TotalUnAppliedPremium"],
                    [dictBasicPlanData valueForKey:@"TargetValue"],
                    [dictBasicPlanData valueForKey:@"ExtraPremiumPercentage"],
                    [dictBasicPlanData valueForKey:@"ExtraPremiumMil"],
                    [dictBasicPlanData valueForKey:@"ExtraPremiumTerm"],
                    [dictBasicPlanData valueForKey:@"Payment_Term"],
                    [dictBasicPlanData valueForKey:@"Payment_Frequency"],
                    [dictBasicPlanData valueForKey:@"PaymentCurrency"],
                    [dictBasicPlanData valueForKey:@"TotalPremium"],
                    [dictBasicPlanData valueForKey:@"SINO"]];
    
    if (!success) {
        NSLog(@"%s: insert error: %@", __FUNCTION__, [database lastErrorMessage]);
        // do whatever you need to upon error
    }
    [results close];
    [database close];
}

-(NSDictionary *)getBasicPlanDataFor:(NSString *)SINo{
    NSDictionary *dict;
    
    NSString* SINO;
    NSString* PaymentMode;
    NSString* PreferredPremium;
    NSString* RegularTopUp;
    NSString* Premium;
    NSString* SumAssured;
    NSString* PremiumHolidayTerm;
    NSString* TotalUnAppliedPremium;
    NSString* TargetValue;
    NSString* ExtraPremiumPercentage;
    NSString* ExtraPremiumMil;
    NSString* ExtraPremiumTerm;
    NSString* Payment_Term;
    NSString* Payment_Frequency;
    NSString* PaymentCurrency;
    NSString* TotalPremium;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select * from SI_BasicPlan where SINO = \"%@\"",SINo]];
    while ([s next]) {
        SINO = [s stringForColumn:@"SINO"];
        PaymentMode = [s stringForColumn:@"PaymentMode"];
        PreferredPremium = [s stringForColumn:@"PreferredPremium"];
        RegularTopUp = [s stringForColumn:@"RegularTopUp"];
        Premium = [s stringForColumn:@"Premium"];
        SumAssured = [s stringForColumn:@"SumAssured"];
        PremiumHolidayTerm = [s stringForColumn:@"PremiumHolidayTerm"];
        TotalUnAppliedPremium = [s stringForColumn:@"TotalUnAppliedPremium"];
        TargetValue = [s stringForColumn:@"TargetValue"];
        ExtraPremiumPercentage = [s stringForColumn:@"ExtraPremiumPercentage"];
        ExtraPremiumMil = [s stringForColumn:@"ExtraPremiumMil"];
        ExtraPremiumTerm = [s stringForColumn:@"ExtraPremiumTerm"];
        Payment_Term = [s stringForColumn:@"Payment_Term"];
        Payment_Frequency = [s stringForColumn:@"Payment_Frequency"];
        PaymentCurrency = [s stringForColumn:@"PaymentCurrency"];
        TotalPremium = [s stringForColumn:@"TotalPremium"];
    }
    
    dict=[[NSDictionary alloc]initWithObjectsAndKeys:
          SINO,@"SINO",
          PaymentMode,@"PaymentMode",
          PreferredPremium,@"PreferredPremium",
          RegularTopUp,@"RegularTopUp",
          Premium,@"Premium",
          SumAssured,@"SumAssured",
          PremiumHolidayTerm,@"PremiumHolidayTerm",
          TotalUnAppliedPremium,@"TotalUnAppliedPremium",
          TargetValue,@"TargetValue",
          ExtraPremiumPercentage ,@"ExtraPremiumPercentage",
          ExtraPremiumMil ,@"ExtraPremiumMil",
          ExtraPremiumTerm ,@"ExtraPremiumTerm",
          Payment_Term ,@"Payment_Term",
          Payment_Frequency ,@"Payment_Frequency",
          PaymentCurrency,@"PaymentCurrency",
          TotalPremium,@"TotalPremium",nil];
    
    [results close];
    [database close];
    return dict;
}


@end
