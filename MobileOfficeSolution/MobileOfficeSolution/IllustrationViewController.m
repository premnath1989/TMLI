//
//  IllustrationViewController.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/18/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "IllustrationViewController.h"
#import "ModelGeneralQueryRates.h"
#import "String.h"
@interface IllustrationViewController (){
    ModelGeneralQueryRates  *modelGeneralQueryRates;
}

@end

@implementation IllustrationViewController
@synthesize delegate;
-(void)viewDidAppear:(BOOL)animated{
    modelGeneralQueryRates = [[ModelGeneralQueryRates alloc]init];
    [self LoadPage3Data];
    [self joinHTML];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)LoadPage3Data{
    NSDictionary* dictPOLAData = [delegate getPOLADictionary];
    NSDictionary* dictBasicPlanData = [delegate getBasicPlanDictionary];
    
    NSString* productCode = [NSString stringWithFormat:@"\"%@\"",[dictPOLAData valueForKey:@"ProductCode"]];
    NSString* laGender = [dictPOLAData valueForKey:@"LA_Gender"];
    NSString* currency = [dictBasicPlanData valueForKey:@"PaymentCurrency"];
    //NSString* planCode ;
    
    laGender = [self ConvertGenderString:laGender];
    
    NSArray* arrayPolisYearProductCode = [[NSArray alloc]initWithObjects:@"PY",productCode, nil];
    NSArray* arrayAgeGender = [[NSArray alloc]initWithObjects:@"Age",laGender, nil];
    NSArray* arrayAgeProductCode = [[NSArray alloc]initWithObjects:@"Age",productCode, nil];
    NSArray* arrayPolisYearHSRFactor = [[NSArray alloc]initWithObjects:@"PY",@"HSR_FACTOR", nil];
    NSArray* arrayJuvenile = [[NSArray alloc]initWithObjects:@"AgeFrom",@"AgeTo",@"Rate", nil];
    NSArray* arrayAdvMedicare = [[NSArray alloc]initWithObjects:@"Age_band",@"Plan_A",@"Plan_B",@"Plan_C",@"Plan_D",@"Plan_E",@"Plan_F",
                                 nil];
    NSArray* arrayHSRCOR = [[NSArray alloc]initWithObjects:@"Age",@"ID200",@"ID500",@"ID1000",@"ID1500",@"IDP500",@"IDP1000",@"IDP1500",@"SD500",@"SD1000",@"SD1500",@"SDP500",@"SDP1000",@"SDP1500",
                                 nil];
    if ([currency isEqualToString:@"USD"]){
        productCode = [NSString stringWithFormat:@"%@_USD",productCode];
    }
    //Prepare Rates Data
    
    //1. Loyalty Bonus (PY,ProductCode)
    NSMutableArray* arrLoyaltyBonus = [modelGeneralQueryRates getRateData:arrayPolisYearProductCode StringTableName:TABLE_RATES_LOYALTY_BONUS];
    //2. RegPremAllo (PY,ProductCode)
    NSMutableArray* arrRegPremAllo = [modelGeneralQueryRates getRateData:arrayPolisYearProductCode StringTableName:TABLE_RATES_REG_PREM_ALLO];
    //3. PremTopUpAll (PY,ProductCode)
    NSMutableArray* arrPremTopUpAll = [modelGeneralQueryRates getRateData:arrayPolisYearProductCode StringTableName:TABLE_RATES_PREM_TOPUP_ALL];
    //4. COI (Age,Gender)
    NSMutableArray* arrCOI = [modelGeneralQueryRates getRateData:arrayAgeGender StringTableName:TABLE_RATES_COI];
    //5. PolicyAdmin (PY,ProductCode)
    NSMutableArray* arrPolicyAdmin = [modelGeneralQueryRates getRateData:arrayPolisYearProductCode StringTableName:TABLE_RATES_POLICY_ADMIN];
    //6. ServiceCharge (PY,ProductCode)
    NSMutableArray* arrServiceCharge = [modelGeneralQueryRates getRateData:arrayPolisYearProductCode StringTableName:TABLE_RATES_SERVICE_CHARGE];
    //7. PremiumHolidayCharge (PY,ProductCode)
    NSMutableArray* arrPermiumHolidayCharge = [modelGeneralQueryRates getRateData:arrayPolisYearProductCode StringTableName:TABLE_RATES_PREMIUM_HOLIDAY_CHARGE];
    //9. WithDrawalChargeRate (PY,ProductCode)
    NSMutableArray* arrWithdrawalChargeRate = [modelGeneralQueryRates getRateData:arrayPolisYearProductCode StringTableName:TABLE_RATES_WITHDRAWAL_CHARGE_RATE];
    //10. ScheduleWithdrawalRate (Age,ProductCode)
    NSMutableArray* arrScheduleWithdrawalRate = [modelGeneralQueryRates getRateData:arrayPolisYearProductCode StringTableName:TABLE_RATES_SCHEDULE_WITHDRAWAL_RATE];
    //11. SurrenderChargeRate (PY,ProductCode)
    NSMutableArray* arrSurrenderChargeRate = [modelGeneralQueryRates getRateData:arrayPolisYearProductCode StringTableName:TABLE_RATES_SURRENDER_CHARGE_RATE];
    //12. Juvenile (AgeFrom,AgeTo,Rate)
    NSMutableArray* arrJuvenileRate = [modelGeneralQueryRates getRateData:arrayJuvenile StringTableName:TABLE_RATES_JUVENILE];
    //13. Adv_MediCare (Age_band,PlanCode) ambil semua kolom
    NSMutableArray* arrAdvMedicareRate = [modelGeneralQueryRates getRateData:arrayAdvMedicare StringTableName:TABLE_RATES_ADVANCE_MEDICARE];
    //14. CI55_Rate (Age,Gender)
    NSMutableArray* arrCI55 = [modelGeneralQueryRates getRateData:arrayAgeGender StringTableName:TABLE_RATES_CI55];
    //15. CI_Early_Rate (Age,Gender)
    NSMutableArray* arrCIEE = [modelGeneralQueryRates getRateData:arrayAgeGender StringTableName:TABLE_RATES_CIEE];
    //16. CashPlan_Rate (Age,Gender)
    NSMutableArray* arrCashPlan = [modelGeneralQueryRates getRateData:arrayAgeGender StringTableName:TABLE_RATES_CASH_PLAN];
    //17. HSR_COR (Age,PlanCode) ambil semua kolom
    NSMutableArray* arrHSRCOR = [modelGeneralQueryRates getRateData:arrayHSRCOR StringTableName:TABLE_RATES_HSR_COR];
    //18. HSR_Factor (PY,HSR_Factor)
    NSMutableArray* arrHSRFactor = [modelGeneralQueryRates getRateData:arrayPolisYearHSRFactor StringTableName:TABLE_RATES_HSR_FACTOR];
    
    
    NSString *jsonPOLAString;
    NSError *error;
    NSData *jsonPOLAData = [NSJSONSerialization dataWithJSONObject:[delegate getPOLADictionary]
                                                           options:0 // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
    
    if (! jsonPOLAData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonPOLAString = [[NSString alloc] initWithData:jsonPOLAData encoding:NSUTF8StringEncoding];
    }
    
    NSString *jsonBasicPlanString;
    NSData *jsonBasicPlanData = [NSJSONSerialization dataWithJSONObject:[delegate getBasicPlanDictionary]
                                                                options:0 // Pass 0 if you don't care about the readability of the generated string
                                                                  error:&error];
    
    if (! jsonBasicPlanData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonBasicPlanString = [[NSString alloc] initWithData:jsonBasicPlanData encoding:NSUTF8StringEncoding];
    }
    
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"dictPOLAData=%@;",jsonPOLAString]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"dictBasicPlan=%@;",jsonBasicPlanString]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"dictFundAllocationData=%@;",[self StringJSONArrayFundAllocation]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"dictRiderData=%@;",[self StringJSONArrayRider]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"dictTopUpWithDrawData=%@;",[self StringJSONTopUpWithDraw]]];
    
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrLoyaltyBonus=%@;",[self ConvertArrayToStringJSON:arrLoyaltyBonus StringJSONKey:@"arrLoyaltyBonus"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrRegPremAllo=%@;",[self ConvertArrayToStringJSON:arrRegPremAllo StringJSONKey:@"arrRegPremAllo"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrPremTopUpAll=%@;",[self ConvertArrayToStringJSON:arrPremTopUpAll StringJSONKey:@"arrPremTopUpAll"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrCOI=%@;",[self ConvertArrayToStringJSON:arrCOI StringJSONKey:@"arrCOI"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrPolicyAdmin=%@;",[self ConvertArrayToStringJSON:arrPolicyAdmin StringJSONKey:@"arrPolicyAdmin"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrServiceCharge=%@;",[self ConvertArrayToStringJSON:arrServiceCharge StringJSONKey:@"arrServiceCharge"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrPermiumHolidayCharge=%@;",[self ConvertArrayToStringJSON:arrPermiumHolidayCharge StringJSONKey:@"arrPermiumHolidayCharge"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrWithdrawalChargeRate=%@;",[self ConvertArrayToStringJSON:arrWithdrawalChargeRate StringJSONKey:@"arrWithdrawalChargeRate"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrScheduleWithdrawalRate=%@;",[self ConvertArrayToStringJSON:arrScheduleWithdrawalRate StringJSONKey:@"arrScheduleWithdrawalRate"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrSurrenderChargeRate=%@;",[self ConvertArrayToStringJSON:arrSurrenderChargeRate StringJSONKey:@"arrSurrenderChargeRate"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrJuvenileRate=%@;",[self ConvertArrayToStringJSON:arrJuvenileRate StringJSONKey:@"arrJuvenileRate"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrAdvMedicareRate=%@;",[self ConvertArrayToStringJSON:arrAdvMedicareRate StringJSONKey:@"arrAdvMedicareRate"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrCI55=%@;",[self ConvertArrayToStringJSON:arrCI55 StringJSONKey:@"arrCI55"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrCIEE=%@;",[self ConvertArrayToStringJSON:arrCIEE StringJSONKey:@"arrCIEE"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrCashPlan=%@;",[self ConvertArrayToStringJSON:arrCashPlan StringJSONKey:@"arrCashPlan"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrHSRCOR=%@;",[self ConvertArrayToStringJSON:arrHSRCOR StringJSONKey:@"arrHSRCOR"]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"arrHSRFactor=%@;",[self ConvertArrayToStringJSON:arrHSRFactor StringJSONKey:@"arrHSRFactor"]]];
    
    
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"CreateTableBenefitProjection();"]];
}

-(void)joinHTML{
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"SI_UL_Page1" ofType:@"html"]; //
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"SI_UL_Page2" ofType:@"html"]; //
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"SI_UL_Page3" ofType:@"html"]; //
    
    
    NSURL *pathURL1 = [NSURL fileURLWithPath:path1];
    NSURL *pathURL2 = [NSURL fileURLWithPath:path2];
    NSURL *pathURL3 = [NSURL fileURLWithPath:path3];
    
    NSArray* path_forDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString* documentsDirectory = [path_forDirectory objectAtIndex:0];
    
    NSMutableData* data;
    data = [NSMutableData dataWithContentsOfURL:pathURL1];
    NSData* data2 = [NSData dataWithContentsOfURL:pathURL2];
    NSData* data3 = [NSData dataWithContentsOfURL:pathURL3];
    [data appendData:data2];
    [data appendData:data3];
    
    [data writeToFile:[NSString stringWithFormat:@"%@/SI_Temp.html",documentsDirectory] atomically:YES];
    
    NSString *HTMLPath = [documentsDirectory stringByAppendingPathComponent:@"SI_Temp.html"];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString* htmlString = [NSString stringWithContentsOfFile:HTMLPath encoding:NSUTF8StringEncoding error:nil];
    [webIllustration loadHTMLString:htmlString baseURL:baseURL];
}

-(IBAction)actionCloseViewIllustration:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)StringJSONArrayFundAllocation{
    NSString *jsonFundAllocationString;
    NSError *error;
    NSDictionary* dictFundAlloc = [[NSDictionary alloc]initWithObjectsAndKeys:[delegate getInvestmentArray],@"FundAlloc", nil];
    NSData *jsonFundAllocationData = [NSJSONSerialization dataWithJSONObject:dictFundAlloc
                                                                options:0 // Pass 0 if you don't care about the readability of the generated string
                                                                  error:&error];
    
    if (! jsonFundAllocationData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonFundAllocationString = [[NSString alloc] initWithData:jsonFundAllocationData encoding:NSUTF8StringEncoding];
    }
    return jsonFundAllocationString;
}

-(NSString *)StringJSONArrayRider{
    NSString *jsonRiderString;
    NSError *error;
    NSDictionary* dictRider = [[NSDictionary alloc]initWithObjectsAndKeys:[delegate getRiderArray],@"Rider", nil];
    NSData *jsonRiderData = [NSJSONSerialization dataWithJSONObject:dictRider
                                                                     options:0 // Pass 0 if you don't care about the readability of the generated string
                                                                       error:&error];
    
    if (! jsonRiderData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonRiderString = [[NSString alloc] initWithData:jsonRiderData encoding:NSUTF8StringEncoding];
    }
    return jsonRiderString;
}

-(NSString *)ConvertArrayToStringJSON:(NSMutableArray *)arrayData StringJSONKey:(NSString *)stringKey{
    NSString *jsonResult;
    NSError *error;
    NSDictionary* dictData = [[NSDictionary alloc]initWithObjectsAndKeys:arrayData,stringKey, nil];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictData
                                                                    options:0 // Pass 0 if you don't care about the readability of the generated string
                                                                      error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonResult = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonResult;
}

-(NSString *)StringJSONTopUpWithDraw{
    NSString *jsonTopUpWithDrawString;
    NSError *error;
    NSDictionary* dictTopUpWithDraw = [[NSDictionary alloc]initWithObjectsAndKeys:[delegate getTopUpWithDrawArray],@"TopUpWithDraw", nil];
    NSData *jsonTopUpWithDrawData = [NSJSONSerialization dataWithJSONObject:dictTopUpWithDraw
                                                            options:0 // Pass 0 if you don't care about the readability of the generated string
                                                              error:&error];
    
    if (! jsonTopUpWithDrawData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonTopUpWithDrawString = [[NSString alloc] initWithData:jsonTopUpWithDrawData encoding:NSUTF8StringEncoding];
    }
    return jsonTopUpWithDrawString;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *jsonPOLAString;
    NSError *error;
    NSData *jsonPOLAData = [NSJSONSerialization dataWithJSONObject:[delegate getPOLADictionary]
                                                                      options:0 // Pass 0 if you don't care about the readability of the generated string
                                                                        error:&error];                                                             
    
    if (! jsonPOLAData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonPOLAString = [[NSString alloc] initWithData:jsonPOLAData encoding:NSUTF8StringEncoding];
    }
    
    NSString *jsonBasicPlanString;
    NSData *jsonBasicPlanData = [NSJSONSerialization dataWithJSONObject:[delegate getBasicPlanDictionary]
                                                           options:0 // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
    
    if (! jsonBasicPlanData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonBasicPlanString = [[NSString alloc] initWithData:jsonBasicPlanData encoding:NSUTF8StringEncoding];
    }
    [self LoadPage3Data];
    
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"SetCalonPemegangPolisData(%@);",jsonPOLAString]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"SetCalonTertanggungData(%@);",jsonPOLAString]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"SetAsuransiDasarData(%@);",jsonBasicPlanString]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"SetFundAllocationInformation(%@);",[self StringJSONArrayFundAllocation]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"SetRiderInformation(%@);",[self StringJSONArrayRider]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"SetTopUpWithDrawInformation(%@,%@,%@);",jsonPOLAString,[self StringJSONTopUpWithDraw],jsonBasicPlanString]];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
