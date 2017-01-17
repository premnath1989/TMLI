//
//  ModelSIRiderSelected.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/13/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
@interface ModelSIRiderSelected : NSObject{
    FMResultSet *results;
}
-(NSMutableArray *)getRiderSelectedDataFor:(NSString *)SINo;
-(void)deleteRiderData:(NSString *)stringSINO;
-(void)saveRiderData:(NSMutableDictionary *)dictRiderData;
@end
