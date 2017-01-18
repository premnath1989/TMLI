//
//  ModelSIRiderPlan.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/13/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "ModelSIRiderPlan.h"
#import "String.h"

@implementation ModelSIRiderPlan
-(NSMutableArray *)getRiderPlanForRiderTypeID:(int)RiderTypeID{
    NSMutableArray* arrayRiderPlan = [[NSMutableArray alloc]init];
    NSDictionary *dict;
    
    int ID;
    int SI_RiderType_ID;
    NSString* SI_RiderType_Code;
    NSString* SI_RiderPlan_Code;
    NSString* SI_RiderPlan_Desc;
    NSString* SI_RiderPlan_Benefit;
    NSString* SI_RiderPlan_LA_Min_EntryAge;
    NSString* SI_RiderPlan_LA_Max_EntryAge;
    NSString* SI_RiderPlan_PO_Min_EntryAge;
    NSString* SI_RiderPlan_PO_Max_EntryAge;
    NSString* SI_RiderPlan_PersonType_LA;
    NSString* SI_RiderPlan_PersonType_PO;
    
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select %@.*,%@.SI_RiderType_Code from %@ %@ join %@ %@ on %@.ID = %@.SI_RiderType_ID where %@.SI_RiderType_ID = %i",TABLE_SI_RIDER_PLAN,TABLE_SI_RIDER_TYPE,TABLE_SI_RIDER_PLAN,TABLE_SI_RIDER_PLAN,TABLE_SI_RIDER_TYPE,TABLE_SI_RIDER_TYPE,TABLE_SI_RIDER_TYPE,TABLE_SI_RIDER_PLAN,TABLE_SI_RIDER_PLAN,RiderTypeID]];
    while ([s next]) {
        ID = [s intForColumn:@"ID"];
        SI_RiderType_ID = [s intForColumn:@"SI_RiderType_ID"];
        SI_RiderPlan_Code = [s stringForColumn:@"SI_RiderPlan_Code"];
        SI_RiderType_Code = [s stringForColumn:@"SI_RiderType_Code"];
        SI_RiderPlan_Desc = [s stringForColumn:@"SI_RiderPlan_Desc"];
        SI_RiderPlan_Benefit = [s stringForColumn:@"SI_RiderPlan_Benefit"];
        SI_RiderPlan_LA_Min_EntryAge = [s stringForColumn:@"SI_RiderPlan_LA_Min_EntryAge"];
        SI_RiderPlan_LA_Max_EntryAge = [s stringForColumn:@"SI_RiderPlan_LA_Max_EntryAge"];
        SI_RiderPlan_PO_Min_EntryAge = [s stringForColumn:@"SI_RiderPlan_PO_Min_EntryAge"];
        SI_RiderPlan_PO_Max_EntryAge = [s stringForColumn:@"SI_RiderPlan_PO_Max_EntryAge"];
        SI_RiderPlan_PersonType_LA = [s stringForColumn:@"SI_RiderPlan_PersonType_LA"];
        SI_RiderPlan_PersonType_PO = [s stringForColumn:@"SI_RiderPlan_PersonType_PO"];
        
        dict=[[NSDictionary alloc]initWithObjectsAndKeys:
              [NSNumber numberWithInteger:ID],@"ID",
              [NSNumber numberWithInteger:SI_RiderType_ID],@"SI_RiderType_ID",
              SI_RiderPlan_Code,@"SI_RiderPlan_Code",
              SI_RiderType_Code,@"SI_RiderType_Code",
              SI_RiderPlan_Desc,@"SI_RiderPlan_Desc",
              SI_RiderPlan_Benefit,@"SI_RiderPlan_Benefit",
              SI_RiderPlan_LA_Min_EntryAge,@"SI_RiderPlan_LA_Min_EntryAge",
              SI_RiderPlan_LA_Max_EntryAge,@"SI_RiderPlan_LA_Max_EntryAge",
              SI_RiderPlan_PO_Min_EntryAge,@"SI_RiderPlan_PO_Min_EntryAge",
              SI_RiderPlan_PO_Max_EntryAge,@"SI_RiderPlan_PO_Max_EntryAge",
              SI_RiderPlan_PersonType_LA,@"SI_RiderPlan_PersonType_LA",
              SI_RiderPlan_PersonType_PO,@"SI_RiderPlan_PersonType_PO",
              nil];
        
        [arrayRiderPlan addObject:dict];
    }
    
    
    [results close];
    [database close];
    return arrayRiderPlan;
}
@end
