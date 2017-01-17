//
//  ModelHSRFactor.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/17/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
@interface ModelHSRFactor : NSObject{
    FMResultSet *results;
}
-(double)getHSRFactor:(int)LAAge;

@end
