//
//  ModelCI55Rates.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/16/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
@interface ModelCI55Rates : NSObject{
    FMResultSet *results;
}
-(double)getRateCI55:(int)LAAge StringGender:(NSString *)stringGender;

@end
