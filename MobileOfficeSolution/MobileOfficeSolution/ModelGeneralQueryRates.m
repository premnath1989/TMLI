//
//  ModelGeneralQueryRates.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/20/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "ModelGeneralQueryRates.h"
#import "String.h"

@implementation ModelGeneralQueryRates
-(NSMutableArray *)getRateData:(NSArray *)stringRatesColumns StringTableName:(NSString *)stringTableName{
    NSMutableArray* arrayRatesData = [[NSMutableArray alloc]init];
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_RATES_MAIN_NAME];
    
    NSString * columns = [[stringRatesColumns valueForKey:@"description"] componentsJoinedByString:@","];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select %@ from %@",columns,stringTableName]];
    
    
    while ([s next]) {
        NSMutableDictionary* dictRatesData = [[NSMutableDictionary alloc]init];
        for (int i=0;i<[stringRatesColumns count];i++){
            NSString* stringColName = [[stringRatesColumns objectAtIndex:i] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            [dictRatesData setObject:[s stringForColumn:stringColName]?:@"" forKey:[stringRatesColumns objectAtIndex:i]];
        }
        [arrayRatesData addObject:dictRatesData];
    }
    
    [results close];
    [database close];
    return arrayRatesData;
}
@end
