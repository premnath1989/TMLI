//
//  SIRiderCalculation.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/16/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "SIRiderCalculation.h"

@implementation SIRiderCalculation

-(int)getMinValue:(int)intValue1 Value2:(int)intValue2{
    int minValue = 0;
    if (intValue1 > intValue2){
        minValue = intValue2;
    }
    else{
        minValue = intValue1;
    }
    return minValue;
}

-(int)CalculateRiderTerm:(NSString *)stringRiderTypeCode StringPlanTyCode:(NSString *)stringPlanTypeCode StringProductCode:(NSString *)stringProductCode IntEntryAge:(int)intEntryAge{
    int riderTerm = 0;
    
    int basicTerm = 99 - intEntryAge;
    if ([stringRiderTypeCode isEqualToString:@"HSR"]){
        int rawRiderTerm = 88 - intEntryAge;
        riderTerm = [self getMinValue:rawRiderTerm Value2:basicTerm];
    }
    else if ([stringRiderTypeCode isEqualToString:@"CI"]){
        if ([stringPlanTypeCode isEqualToString:@"CIEE"]){
            int rawRiderTerm = 65 - intEntryAge;
            riderTerm = [self getMinValue:rawRiderTerm Value2:basicTerm];
        }
        else if ([stringPlanTypeCode isEqualToString:@"CI55"]){
            int rawRiderTerm = 88 - intEntryAge;
            riderTerm = [self getMinValue:rawRiderTerm Value2:basicTerm];
        }
    }
    else if ([stringRiderTypeCode isEqualToString:@"HCP"]){
        int rawRiderTerm = 65 - intEntryAge;
        riderTerm = [self getMinValue:rawRiderTerm Value2:basicTerm];
    }
    else if ([stringRiderTypeCode isEqualToString:@"PA"]){
        int rawRiderTerm = 65 - intEntryAge;
        riderTerm = [self getMinValue:rawRiderTerm Value2:basicTerm];
    }
    else if ([stringRiderTypeCode isEqualToString:@"PW"]){
        int rawRiderTerm = 65 - intEntryAge;
        riderTerm = [self getMinValue:rawRiderTerm Value2:basicTerm];
    }
    else if ([stringRiderTypeCode isEqualToString:@"WR"]){
        int rawRiderTerm = 65 - intEntryAge;
        riderTerm = [self getMinValue:rawRiderTerm Value2:basicTerm];
    }
    else if ([stringRiderTypeCode isEqualToString:@"ADM"]){
        int rawRiderTerm = 65 - intEntryAge;
        riderTerm = [self getMinValue:rawRiderTerm Value2:basicTerm];
    }
    
    return riderTerm;
}

-(int)getMOPValue:(NSString *)stringPaymentFrequency{
    int mopVal = 0;
    if ([stringPaymentFrequency isEqualToString:@"Tahunan"]){
        mopVal = 1;
    }
    else if ([stringPaymentFrequency isEqualToString:@"Semester"]){
        mopVal = 2;
    }
    else if ([stringPaymentFrequency isEqualToString:@"Kuartal"]){
        mopVal = 4;
    }
    else if ([stringPaymentFrequency isEqualToString:@"Bulanan"]){
        mopVal = 12;
    }
    return mopVal;
}

-(NSString *)ConvertGenderString:(NSString *)stringGender{
    NSString *strGender;
    if ([stringGender isEqualToString:@"MALE"]){
        strGender = @"Male";
    }
    else if ([stringGender isEqualToString:@"FEMALE"]){
        strGender = @"Female";
    }
    return strGender;
}


-(long long)CalculateCashOfRider:(NSDictionary *)dictRiderInformation{
    long long riderCOR = 0;
    
    NSString *stringRiderTypeCode = [dictRiderInformation valueForKey:@"SI_RiderType_Code"];
    NSString *stringPlanTypeCode = [dictRiderInformation valueForKey:@"SI_RiderPlan_Code"];
    //int MOP = [self getMOPValue:[dictRiderInformation valueForKey:@"PaymentFrequency"]];

    if ([stringRiderTypeCode isEqualToString:@"HSR"]){
        riderCOR = [self calculateHSRCOR:dictRiderInformation];
    }
    else if ([stringRiderTypeCode isEqualToString:@"CI"]){
        if ([stringPlanTypeCode isEqualToString:@"CIEE"]){
            riderCOR = [self calculateCIEECOR:dictRiderInformation];
        }
        else if ([stringPlanTypeCode isEqualToString:@"CI55"]){
            riderCOR = [self calculateCI55COR:dictRiderInformation];
        }
    }
    else if ([stringRiderTypeCode isEqualToString:@"HCP"]){
        riderCOR = [self calculateHCPCOR:dictRiderInformation];
    }
    else if ([stringRiderTypeCode isEqualToString:@"PA"]){
        if ([stringPlanTypeCode isEqualToString:@"PAA"]){
            riderCOR = [self calculatePAACOR:dictRiderInformation];
        }
        else if ([stringPlanTypeCode isEqualToString:@"PAAB"]){
            riderCOR = [self calculatePAABCOR:dictRiderInformation];
        }
    }
    else if ([stringRiderTypeCode isEqualToString:@"PW"]){
        riderCOR = [self calculatePWCOR:dictRiderInformation];
    }
    else if ([stringRiderTypeCode isEqualToString:@"WR"]){
        riderCOR = [self calculateWRCOR:dictRiderInformation];
    }
    else if ([stringRiderTypeCode isEqualToString:@"ADM"]){
        riderCOR = [self calculateADMCOR:dictRiderInformation];
    }
    
    return riderCOR;
}

-(int)getHCPPlanType:(NSString *)stringPlanCode{
    int hcpPlanType = 0;
    if ([stringPlanCode rangeOfString:@"100"].location != NSNotFound) {
        hcpPlanType = 2;
    }
    else if ([stringPlanCode rangeOfString:@"200"].location != NSNotFound) {
        hcpPlanType = 4;
    }
    else if ([stringPlanCode rangeOfString:@"300"].location != NSNotFound) {
        hcpPlanType = 6;
    }
    else if ([stringPlanCode rangeOfString:@"400"].location != NSNotFound) {
        hcpPlanType = 8;
    }
    else if ([stringPlanCode rangeOfString:@"500"].location != NSNotFound) {
        hcpPlanType = 10;
    }
    return hcpPlanType;
}

-(long long)calculateHSRCOR:(NSDictionary *)dictRiderInformation{
    long long riderCOR = 0;
    modelHSRCor = [[ModelHSRCOR alloc]init];
    modelHSRFactor = [[ModelHSRFactor alloc]init];
    int LAAge = [[dictRiderInformation valueForKey:@"LA_Age"] intValue];
//    NSString *stringGender = [self ConvertGenderString:[dictRiderInformation valueForKey:@"LA_Gender"]];
    NSString *stringPlan = [dictRiderInformation valueForKey:@"SI_RiderPlan_Code"];
    
    int extraPremiPercent = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Percent"] intValue];
    int extraPremiMil = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Mil"] intValue];
    
    double hsrFactor = [modelHSRFactor getHSRFactor:LAAge];
    double hsrCor = [modelHSRCor getHSRCOR:LAAge StringPlanCode:stringPlan];
    
    riderCOR = (hsrCor * 0.0833 * hsrFactor) * (1 + extraPremiPercent) + extraPremiMil ;
    return riderCOR;
}

-(long long)calculateCIEECOR:(NSDictionary *)dictRiderInformation{
    long long riderCOR = 0;
    modelCIEE = [[ModelCIEERates alloc]init];
    int LAAge = [[dictRiderInformation valueForKey:@"LA_Age"] intValue];
    NSString *stringGender = [self ConvertGenderString:[dictRiderInformation valueForKey:@"LA_Gender"]];
    double rateCIEE = [modelCIEE getRateCIEE:LAAge StringGender:stringGender];
    
    formatter  = [[Formatter alloc]init];
    long long riderSA = [[formatter convertNumberFromStringCurrency:[dictRiderInformation valueForKey:@"SI_RiderSelected_Benefit"]] longLongValue];
    int extraPremiPercent = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Percent"] intValue];
    int extraPremiMil = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Mil"] intValue];
    
    riderCOR = (rateCIEE * (riderSA/1000) * 0.0833) + (1 + extraPremiPercent) + (extraPremiMil * (riderSA/1000) * 0.0833);
    
    return riderCOR;
}

-(long long)calculateCI55COR:(NSDictionary *)dictRiderInformation{
    long long riderCOR = 0;
    modelCI55 = [[ModelCI55Rates alloc]init];
    int LAAge = [[dictRiderInformation valueForKey:@"LA_Age"] intValue];
    NSString *stringGender = [self ConvertGenderString:[dictRiderInformation valueForKey:@"LA_Gender"]];
    double rateCI55 = [modelCI55 getRateCI55:LAAge StringGender:stringGender];
    
    formatter  = [[Formatter alloc]init];
    long long riderSA = [[formatter convertNumberFromStringCurrency:[dictRiderInformation valueForKey:@"SI_RiderSelected_Benefit"]] longLongValue];
    int extraPremiPercent = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Percent"] intValue];
    int extraPremiMil = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Mil"] intValue];
    
    riderCOR = (rateCI55 * (riderSA/1000) * 0.0833) + (1 + extraPremiPercent) + (extraPremiMil * (riderSA/1000) * 0.0833);
    
    return riderCOR;
}

-(long long)calculateHCPCOR:(NSDictionary *)dictRiderInformation{
    long long riderCOR = 0;
    modelCashPlanRate = [[ModelCashPlanRate alloc]init];
    int LAAge = [[dictRiderInformation valueForKey:@"LA_Age"] intValue];
    NSString *stringGender = [self ConvertGenderString:[dictRiderInformation valueForKey:@"LA_Gender"]];
    double rateCashPlan = [modelCashPlanRate getRateCashPlan:LAAge StringGender:stringGender];
    
    formatter  = [[Formatter alloc]init];
    int planType = [self getHCPPlanType:[dictRiderInformation valueForKey:@"SI_RiderPlan_Code"]];
    int extraPremiPercent = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Percent"] intValue];
    int extraPremiMil = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Mil"] intValue];
    
    riderCOR = (rateCashPlan * planType * 0.0833) * (1 + extraPremiPercent) + extraPremiMil;
    
    return riderCOR;
}

-(long long)calculatePAACOR:(NSDictionary *)dictRiderInformation{
    long long riderCOR = 0;
    formatter  = [[Formatter alloc]init];
    long long riderSA = [[formatter convertNumberFromStringCurrency:[dictRiderInformation valueForKey:@"SI_RiderSelected_Benefit"]] longLongValue];
    int extraPremiPercent = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Percent"] intValue];
    int extraPremiMil = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Mil"] intValue];
    
    riderCOR = (0.6 * (riderSA/1000) * 0.0833) + (1 + extraPremiPercent) + (extraPremiMil * (riderSA/1000) * 0.0833);
    return riderCOR;
}

-(long long)calculatePAABCOR:(NSDictionary *)dictRiderInformation{
    long long riderCOR = 0;
    formatter  = [[Formatter alloc]init];
    long long riderSA = [[formatter convertNumberFromStringCurrency:[dictRiderInformation valueForKey:@"SI_RiderSelected_Benefit"]] longLongValue];
    int extraPremiPercent = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Percent"] intValue];
    int extraPremiMil = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Mil"] intValue];
    
    riderCOR = (1.35 * (riderSA/1000) * 0.0833) + (1 + extraPremiPercent) + (extraPremiMil * (riderSA/1000) * 0.0833);
    return riderCOR;
}

-(long long)calculatePWCOR:(NSDictionary *)dictRiderInformation{
    long long riderCOR = 0;
    return riderCOR;
}

-(long long)calculateWRCOR:(NSDictionary *)dictRiderInformation{
    long long riderCOR = 0;
    return riderCOR;
}

-(long long)calculateADMCOR:(NSDictionary *)dictRiderInformation{
    long long riderCOR = 0;
    modelAdvanceMedicare = [[ModelAdvanceMedicare alloc]init];
    int LAAge = [[dictRiderInformation valueForKey:@"LA_Age"] intValue];
    NSString *stringPlan = [dictRiderInformation valueForKey:@"SI_RiderPlan_Code"];
    double rateAdvanceMedicare = [modelAdvanceMedicare getRateAdvanceMedicare:LAAge StringPlan:stringPlan];
    
    formatter  = [[Formatter alloc]init];
    int extraPremiPercent = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Percent"] intValue];
    int extraPremiMil = [[dictRiderInformation valueForKey:@"SI_RiderSelected_ExtraPremi_Mil"] intValue];
    
    riderCOR = (rateAdvanceMedicare * 0.0833) + (1 + extraPremiPercent) + extraPremiMil;
    
    return riderCOR;
}

@end
