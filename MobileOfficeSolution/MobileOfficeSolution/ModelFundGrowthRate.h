//
//  ModelFundGrowthRate.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/20/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface ModelFundGrowthRate : NSObject{
    FMResultSet *results;
}
-(double)getRateFundGrowth:(NSString *)FundName StringFundProjection:(NSString *)stringFundProjection;

@end
