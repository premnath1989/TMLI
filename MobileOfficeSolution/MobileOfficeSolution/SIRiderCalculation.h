//
//  SIRiderCalculation.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/16/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Formatter.h"
#import "ModelCI55Rates.h"
#import "ModelCIEERates.h"
#import "ModelAdvanceMedicare.h"
#import "ModelCashPlanRate.h"
#import "ModelHSRCOR.h"
#import "ModelHSRFactor.h"
@interface SIRiderCalculation : NSObject{
    Formatter* formatter;
    ModelCI55Rates* modelCI55;
    ModelCIEERates* modelCIEE;
    ModelAdvanceMedicare* modelAdvanceMedicare;
    ModelCashPlanRate* modelCashPlanRate;
    ModelHSRCOR* modelHSRCor;
    ModelHSRFactor* modelHSRFactor;
}
-(long long)CalculateCashOfRider:(NSDictionary *)dictRiderInformation;
@end
