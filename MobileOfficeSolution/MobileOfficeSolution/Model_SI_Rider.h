//
//  Model_SI_Rider.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/9/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
@interface Model_SI_Rider : NSObject{
    FMResultSet *results;
}

-(void)saveRiderData:(NSMutableDictionary *)dictRiderData;
-(NSMutableArray *)getRiderDataFor:(NSString *)SINo;
-(void)deleteRiderData:(NSString *)stringSINO;

@end
