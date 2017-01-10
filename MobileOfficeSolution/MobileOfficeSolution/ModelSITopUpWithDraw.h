//
//  ModelSISpecialRequest.h
//  BLESS
//
//  Created by Basvi on 11/15/16.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface ModelSITopUpWithDraw : NSObject{
    FMResultSet *results;
}

-(void)saveTopUpWithDrawData:(NSMutableDictionary *)dictTopUpWithDrawData;
-(void)deleteTopUpWithDrawData:(NSString *)stringSINO;
-(NSMutableArray *)getTopUpWithDrawDataFor:(NSString *)SINo;
-(NSMutableArray *)getTopUpWithDrawDataFor:(NSString *)SINo Option:(NSString *)stringOption;
@end
