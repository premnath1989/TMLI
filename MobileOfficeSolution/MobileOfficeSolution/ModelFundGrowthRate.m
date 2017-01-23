//
//  ModelFundGrowthRate.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/20/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "ModelFundGrowthRate.h"
#import "String.h"
@implementation ModelFundGrowthRate
-(double)getRateFundGrowth:(NSString *)FundName StringFundProjection:(NSString *)stringFundProjection{
    double rate = 0;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_RATES_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select %@ from %@ where Fund =\"%@\"",stringFundProjection,TABLE_RATES_FUND_GROWTH,FundName]];
    
    rate = [[s stringForColumn:stringFundProjection] doubleValue];
    while ([s next]) {
        rate = [[s stringForColumn:stringFundProjection] doubleValue];
    }
    
    [results close];
    [database close];
    return rate;
}
@end
