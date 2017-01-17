//
//  ModelCashPlanRate.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/16/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface ModelCashPlanRate : NSObject{
    FMResultSet *results;
}
-(double)getRateCashPlan:(int)LAAge StringGender:(NSString *)stringGender;

@end
