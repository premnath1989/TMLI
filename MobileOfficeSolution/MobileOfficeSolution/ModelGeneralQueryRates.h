//
//  ModelGeneralQueryRates.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/20/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface ModelGeneralQueryRates : NSObject{
    FMResultSet *results;
}
-(NSMutableArray *)getRateData:(NSArray *)stringRatesColumns StringTableName:(NSString *)stringTableName;

@end
