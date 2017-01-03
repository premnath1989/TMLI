//
//  ModelSIULBasicPlan.h
//  BLESS
//
//  Created by Basvi on 11/15/16.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "Model_SI_Master.h"

@interface ModelSIBasicPlan : NSObject{
    FMResultSet *results;
    Model_SI_Master *modelSIMaster;
}

-(void)saveBasicPlanData:(NSMutableDictionary *)dictBasicPlanData;
-(NSDictionary *)getBasicPlanDataFor:(NSString *)SINo;
-(int)getBasicPlanDataCount:(NSString *)SINo;
@end
