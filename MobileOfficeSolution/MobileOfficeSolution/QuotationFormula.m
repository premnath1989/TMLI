//
//  UIViewController+QuotationFormula.m
//  MobileOfficeSolution
//
//  Created by Premnath on 03/01/2017.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "QuotationFormula.h"

@implementation QuotationFormula
@synthesize Year;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)TahunPolisi
{
  
}

-(void)Usia
{
    
}

-(void)PremiRegular
{
  //Quo_Formula!Medium!Col6 /CurrencyRate
  //Col6 = If Premium Term >= Col1 then Regular Premium (Input) * Col4 * Col5   else 0
  //Col4 = If Col1 > Premium Term(input) then 0 else 1
  //Col1 = Start  : 1
  //       End    : follow basic term
  //Col5 =
  //         Monthly
  //          if Col2 value 1 to 12 then Mode set to 1 else 0
  //
  //         Quarterly
  //         if Col2 value is 1 , 4, 7 ,10 then Mode set to 1 else 0
  //
  //          Semi- Annually
  //         if Col2 value is 1 , 7 then Mode set to 1 else 0
  //
  //         Annually
  //         if Col2 value is 1 , then Mode set to 1 else 0
  //Col2 = 1 to 12

    
}

-(void)TopUpRegular
{
    //Quo_Formula!Medium!Col7 /CurrencyRate
    //Col6 = If Premium Term >= Col1 then Regular Top Up (Input) * Col4 * Col5
    //Col4 = If Col1 > Premium Term(input) then 0 else 1
    //Col1 = Start  : 1
    //       End    : follow basic term
    //Col5 =
    //         Monthly
    //          if Col2 value 1 to 12 then Mode set to 1 else 0
    //
    //         Quarterly
    //         if Col2 value is 1 , 4, 7 ,10 then Mode set to 1 else 0
    //
    //          Semi- Annually
    //         if Col2 value is 1 , 7 then Mode set to 1 else 0
    //
    //         Annually
    //         if Col2 value is 1 , then Mode set to 1 else 0
    //Col2 = 1 to 12
}


-(void)TopUpTunggal
{
    
    //Quo_Formula!Medium!Col8 /CurrencyRate
    //1) Insert the single Premium value based on PolYear added by user.
    //3) Single Premium value only display at the 1st month of every year (Col2 = 1)
    //Col2 = 1 to 12
    
}

-(void)PenarikandanaTunggal
{
    //Quo_Formula!Medium!Col39 /CurrencyRate
    //Withdrawal_Amt * (if Col2 = 12 then 1 else 0)
}

-(void)ProyeksiNilaiInvestasiLow :(* double ProyeksiNilaiInvestasiLow)
{
    [self.ProyekSiNilaiInvestasi.LowRates.Open];
    
    //Quo_Formula!Low!Col52 /CurrencyRate || Quo_Formula!Low!Col52 /CurrencyRate ||
    
    */if Col51 + Col49 <= 0 then 0 else Col51 + Col49/
    
    //[self.RP_EOM_Aft_Widraw] = [self.RP_EOM_bfrWidraw]-[self.RP_Widraw_frm_RP]-[self.RP_Witdraw_Charge]+[self.LoyalthyBonus]-[self.RP_Sched_Widraw_fr_RP]
    
    //[self.TU_EOM_After_Widraw] = [self.TopUp_EOM_bfr_Widraw]-[self.TopUp_Widraw_fr_TU]-[self.TU_Sched_Widraw_fr_TU]
    
    //[self.Tot_Fund_EOM_aft_sched_with] = [self.RP_EOM_Aft_Widraw]+[self.TU_EOM_After_Widraw]
        
        if([self.Tot_Fund_EOM_aft_sched_with] <= 0)
        {
            ProyeksiNilaiInvestasiLow == 0;
        }
        else
        {
           ProyeksiNilaiInvestasiLow = [self.Tot_Fund_EOM_aft_sched_with]
        }
    [self.ProyekSiNilaiInvestasi.LowRates.Close];
    
}


-(void)ProyeksiNilaiInvestasiMedium :(* double ProyeksiNilaiInvestasiMedium)
{
    [self.ProyekSiNilaiInvestasi.MediumRates.Open];
    
    //Quo_Formula!Medium!Col52 /CurrencyRate || Quo_Formula!Low!Col52 /CurrencyRate ||
    
    *//if Col51 + Col49 <= 0 then 0 else Col51 + Col49/
        
        [self.RP_EOM_Aft_Widraw] = [self.RP_EOM_bfrWidraw]-[self.RP_Widraw_frm_RP]-[self.RP_Witdraw_Charge]+[self.LoyalthyBonus]-[self.RP_Sched_Widraw_fr_RP]
        
        self.TU_EOM_After_Widraw] = [self.TopUp_EOM_bfr_Widraw]-[self.TopUp_Widraw_fr_TU]-[self.TU_Sched_Widraw_fr_TU]
        
        [self.Tot_Fund_EOM_aft_sched_with] = [self.RP_EOM_Aft_Widraw]+[self.TU_EOM_After_Widraw]
        
        if([self.Tot_Fund_EOM_aft_sched_with] <= 0)
        {
            ProyeksiNilaiInvestasiMedium == 0;
        }
        else
        {
            ProyeksiNilaiInvestasiMedium = [self.Tot_Fund_EOM_aft_sched_with]
        }
    [self.ProyekSiNilaiInvestasi.MediumRates.Close];
    
}

-(void)ProyeksiNilaiInvestasiHigh :(* double ProyeksiNilaiInvestasiHigh)
{
    [self.ProyekSiNilaiInvestasi.HighRates.Open];
    
    //Quo_Formula!High!Col52 /CurrencyRate || Quo_Formula!Low!Col52 /CurrencyRate ||
    
    *//if Col51 + Col49 <= 0 then 0 else Col51 + Col49/
        
        [self.RP_EOM_Aft_Widraw] = [self.RP_EOM_bfrWidraw]-[self.RP_Widraw_frm_RP]-[self.RP_Witdraw_Charge]+[self.LoyalthyBonus]-[self.RP_Sched_Widraw_fr_RP]
        
        [self.TU_EOM_After_Widraw] = [self.TopUp_EOM_bfr_Widraw]-[self.TopUp_Widraw_fr_TU]-[self.TU_Sched_Widraw_fr_TU]
        
        [self.Tot_Fund_EOM_aft_sched_with] = [self.RP_EOM_Aft_Widraw]+[self.TU_EOM_After_Widraw]
        
        if([self.Tot_Fund_EOM_aft_sched_with] <= 0)
        {
            ProyeksiNilaiInvestasiHigh == 0;
        }
        else
        {
            ProyeksiNilaiInvestasiHigh = [self.Tot_Fund_EOM_aft_sched_with]
        }
    [self.ProyekSiNilaiInvestasi.HighRates.Close];
    
}

-(void)ProyeksiManfaatNilaiTebusLow :(* double ProyeksiManfaatNilaiTebusLow)
{
    
    [self.ProyeksiManfaatNilaiTebus.LowRates.Open];
    
    //Quo_Formula!Low!Col54 /CurrencyRate/
    *//If productcode = TML_WA, TML Retirement 55, TML Education, TML retirement 60 , TML_WE then 0
     //else
     //if Col51 - Col53 + Col49 -  Col38 <= then 0 else Col51 - Col53 + Col49 -  Col38
    
    [self.Surrender_Amount] =[self.RP_EOM_Aft_Widraw]-[self.Surrender_Charges]+[self.TU_EOM_After_Widraw]
    
    if(![self.Surrender_Amount] <= 0)
    {
         ProyeksiManfaatNilaiTebusLow = [self.Surrender_Amount] -[self.DebtBalance]
    }
    else
    {
        ProyeksiManfaatNilaiTebusLow = 0;
    }
    
     [self.ProyeksiManfaatNilaiTebus.LowRates.Close];
    
}

-(void)ProyeksiManfaatNilaiTebusMedium :(* double ProyeksiManfaatNilaiTebusMedium)
{
    
    [self.ProyeksiManfaatNilaiTebus.MediumRates.Open];
    
    //Quo_Formula!Medium!Col54 /CurrencyRate/
    *//If productcode = TML_WA, TML Retirement 55, TML Education, TML retirement 60 , TML_WE then 0
    //else
    //if Col51 - Col53 + Col49 -  Col38 <= then 0 else Col51 - Col53 + Col49 -  Col38
    
    [self.Surrender_Amount] =[self.RP_EOM_Aft_Widraw]-[self.Surrender_Charges]+[self.TU_EOM_After_Widraw]
    
    if(![self.Surrender_Amount] <= 0)
    {
        ProyeksiManfaatNilaiTebusMedium = [self.Surrender_Amount] -[self.DebtBalance]
    }
    else
    {
        ProyeksiManfaatNilaiTebusMedium = 0;
    }
    
    [self.ProyeksiManfaatNilaiTebus.MediumRates.Close];
    
}

-(void)ProyeksiManfaatNilaiTebusHigh :(* double ProyeksiManfaatNilaiTebusHigh)
{
    
    [self.ProyeksiManfaatNilaiTebus.HighRates.Open];
    
    //Quo_Formula!High!Col54 /CurrencyRate/
    *//If productcode = TML_WA, TML Retirement 55, TML Education, TML retirement 60 , TML_WE then 0
    //else
    //if Col51 - Col53 + Col49 -  Col38 <= then 0 else Col51 - Col53 + Col49 -  Col38
    
    [self.Surrender_Amount] =[self.RP_EOM_Aft_Widraw]-[self.Surrender_Charges]+[self.TU_EOM_After_Widraw]
    
    if(![self.Surrender_Amount] <= 0)
    {
        ProyeksiManfaatNilaiTebusHigh = [self.Surrender_Amount] -[self.DebtBalance]
    }
    else
    {
        ProyeksiManfaatNilaiTebusHigh = 0;
    }
    
    [self.ProyeksiManfaatNilaiTebus.HighRates.Close];
    
}


-(void)ProyeksiManfaatMeninggalLow :(* double ProyeksiManfaatMeninggalLow)
{
    [self.ProyeksiManfaatMeninggal.LowRates.Open];
    
    //(Quo_Formula!Low!Col55/CurrencyRate) + Col7/
    *//Rate[Juvenile(PolAge)]* Basic Sum Assured (Input) - Col38//
    
    [self.DB_ValueDisplay] = [self.Rate_JuvPloAge]*[self.Basic_Sum]-[self.DebtBalance]
    [self.DB_ValueDisplay] = [sef.DB_ValueDisplay]+[self.ADB_InvestasiKu]
    
    ProyeksiManfaatMeninggalLow = [self.DB_ValueDisplay]
    
    [self.ProyeksiManfaatMeninggal.LowRates.Close];
    
}

-(void)ProyeksiManfaatMeninggalMedium :(* double ProyeksiManfaatMeninggalMedium)
{
    [self.ProyeksiManfaatMeninggal.MediumRates.Open];
    
    //(Quo_Formula!Medium!Col55/CurrencyRate) + Col7/
    *//Rate[Juvenile(PolAge)]* Basic Sum Assured (Input) - Col38//
    
    [self.DB_ValueDisplay] = [self.Rate_JuvPloAge]*[self.Basic_Sum]-[self.DebtBalance]
    [self.DB_ValueDisplay] = [sef.DB_ValueDisplay]+[self.ADB_InvestasiKu]
    
    ProyeksiManfaatMeninggalMedium = [self.DB_ValueDisplay]
    
    [self.ProyeksiManfaatMeninggal.MediumRates.Close];
    
}

-(void)ProyeksiManfaatMeninggalHigh :(* double ProyeksiManfaatMeninggalHigh)
{
    [self.ProyeksiManfaatMeninggal.HighRates.Open];
    
    //(Quo_Formula!High!Col55/CurrencyRate) + Col7/
    *//Rate[Juvenile(PolAge)]* Basic Sum Assured (Input) - Col38//
    
    [self.DB_ValueDisplay] = [self.Rate_JuvPloAge]*[self.Basic_Sum]-[self.DebtBalance]
    [self.DB_ValueDisplay] = [sef.DB_ValueDisplay]+[self.ADB_InvestasiKu]
    
    ProyeksiManfaatMeninggalHigh = [self.DB_ValueDisplay]
    
    [self.ProyeksiManfaatMeninggal.HighRates.Close];
    
}



@end











