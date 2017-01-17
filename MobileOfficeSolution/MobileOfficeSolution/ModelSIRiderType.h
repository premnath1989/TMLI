//
//  ModelSIRiderType.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/13/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
@interface ModelSIRiderType : NSObject{
    FMResultSet *results;
}
-(NSMutableArray *)getRiderTypeIn:(NSString *)RiderTypeCode;

@end
