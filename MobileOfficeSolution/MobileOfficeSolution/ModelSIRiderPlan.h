//
//  ModelSIRiderPlan.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/13/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
@interface ModelSIRiderPlan : NSObject{
    FMResultSet *results;
}
-(NSMutableArray *)getRiderPlanForRiderTypeID:(int)RiderTypeID;

@end
