//
//  ModelHSRCOR.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/17/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
@interface ModelHSRCOR : NSObject{
    FMResultSet *results;
}
-(double)getHSRCOR:(int)LAAge StringPlanCode:(NSString *)stringPlanCode

@end
