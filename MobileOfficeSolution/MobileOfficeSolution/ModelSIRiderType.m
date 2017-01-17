//
//  ModelSIRiderType.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/13/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "ModelSIRiderType.h"
#import "String.h"
@implementation ModelSIRiderType

-(NSMutableArray *)getRiderTypeIn:(NSString *)RiderTypeCode{
    NSMutableArray* arrayRiderType = [[NSMutableArray alloc]init];
    NSDictionary *dict;
    
    int ID;
    NSString* SI_RiderType_Code;
    NSString* SI_RiderType_Desc;
    
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select * from %@ where SI_RiderType_Code in %@",TABLE_SI_RIDER_TYPE,RiderTypeCode]];
    while ([s next]) {
        ID = [s intForColumn:@"ID"];
        SI_RiderType_Code = [s stringForColumn:@"SI_RiderType_Code"];
        SI_RiderType_Desc = [s stringForColumn:@"SI_RiderType_Desc"];
        
        dict=[[NSDictionary alloc]initWithObjectsAndKeys:
              [NSNumber numberWithInteger:ID],@"ID",
              SI_RiderType_Code,@"SI_RiderType_Code",
              SI_RiderType_Desc,@"SI_RiderType_Desc",
              nil];
        
        [arrayRiderType addObject:dict];
    }
    
    
    [results close];
    [database close];
    return arrayRiderType;
}


@end
