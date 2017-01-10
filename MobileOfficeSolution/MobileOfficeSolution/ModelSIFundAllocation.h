//
//  ModelSIULFundAllocation.h
//  BLESS
//
//  Created by Basvi on 11/15/16.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface ModelSIFundAllocation : NSObject{
    FMResultSet *results;
}

-(void)saveFundAllocationData:(NSMutableDictionary *)dictULFundAllocationData;
-(NSMutableArray *)getFundAllocationDataFor:(NSString *)SINo;
-(int)getFundAllocationDataCount:(NSString *)SINo;
-(void)deleteFundAllocationData:(NSString *)stringSINO;
@end
