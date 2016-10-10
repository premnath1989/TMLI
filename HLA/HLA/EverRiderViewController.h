//
//  EverRiderViewController.h
//  MPOS
//
//  Created by infoconnect on 6/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "RiderPTypeTbViewController.h"
#import "RiderListTbViewController.h"
#import "RiderPlanTb.h"
#import "RiderDeducTb.h"
#import "AppDelegate.h"
#import "DeductiblePostRetirement.h"

@class EverRiderViewController;
@protocol EverRiderViewControllerDelegate
-(void) RiderAdded;
-(void) BasicSARevised:(NSString *)aabasicSA;
-(void) RiderGlobalSave;
@end

@interface EverRiderViewController : UIViewController<RiderPTypeTbViewControllerDelegate,RiderListTbViewControllerDelegate,
						UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,RiderDeducTbDelegate,RiderPlanTbDelegate, DeductiblePostRetirementDelegate>{
                            NSString *databasePath;
                            NSString *RatesDatabasePath;
                            NSString *UL_RatesDatabasePath;
                            sqlite3 *contactDB;
                            UIPopoverController *_pTypePopOver;
                            UIPopoverController *_RiderListPopover;
                            UIPopoverController *_planPopover;
                            UIPopoverController *_deducPopover;
                            UIPopoverController *_deducPostRetirementPopover;
                            RiderPTypeTbViewController *_PTypeList;
                            RiderListTbViewController *_RiderList;
                            RiderPlanTb *_planList;
                            RiderDeducTb *_deductList;
                            DeductiblePostRetirement *_deductPostRetirement;
                            id <EverRiderViewControllerDelegate> _delegate;
                            NSMutableArray *ItemToBeDeleted;
                            NSMutableArray *indexPaths;
                            UITextField *activeField;
                            BOOL term;
                            BOOL sumA;
                            BOOL plan;
                            BOOL unit;
                            BOOL deduc;
                            BOOL ECAR6YearlyIncome;
                            BOOL ECARYearlyIncome;
                            BOOL ECAR60MonthlyIncome;
                            BOOL RRTUOPrem;
                            BOOL TSR;
                            BOOL hload;
                            BOOL hloadterm;
                            BOOL hloadPct;
                            BOOL hloadtermPct;
                            BOOL pressedPlan;
                            BOOL pressedDeduc;
                            BOOL incomeRider;
                            BOOL PtypeChange;
                            BOOL Edit;
                            BOOL bALW;
                            BOOL bOverseaTreatment;
                            BOOL bPCB;
                            BOOL bBBB;
                            double OccScale;
                            NSString *strDeductiblePostRetirement;
                            NSString *strDeductiblePreRetirement;
                            NSMutableArray *ReportHMMRates;
                            NSMutableArray *ReportFromAge;
                            NSMutableArray *ReportToAge;
							
                            AppDelegate *appDel;
                            BOOL Editable;
}

@property (nonatomic, retain) UIPopoverController *RiderListPopover;
@property (nonatomic, retain) UIPopoverController *planPopover;
@property (nonatomic, retain) UIPopoverController *deducPopover;
@property (nonatomic, retain) UIPopoverController *deducRetirementPopover;
@property (nonatomic,strong) UIPopoverController *pTypePopOver;
@property (nonatomic, retain) RiderListTbViewController *RiderList;
@property (nonatomic, retain) RiderPlanTb *planList;
@property (nonatomic, retain) RiderDeducTb *deductList;
@property (nonatomic, retain) DeductiblePostRetirement *deductPostRetirement;
@property (nonatomic, retain) RiderPTypeTbViewController *PTypeList;
@property (nonatomic,strong) id <EverRiderViewControllerDelegate> delegate;

@property (nonatomic,strong) id EAPPorSI;
//--request
@property (nonatomic,strong) id requestSINo;
@property (nonatomic,strong) id requestPlanCode;
@property (nonatomic, assign,readwrite) int requestAge;
@property (nonatomic, assign,readwrite) int request2ndAge;
@property (nonatomic, assign,readwrite) int requestPayorAge;
@property (nonatomic,strong) id requestSex;
@property (nonatomic,strong) id requestOccpCode;
@property (nonatomic, assign,readwrite) int requestOccpClass;
@property (nonatomic, assign,readwrite) int requestCoverTerm;
@property (nonatomic, strong) id requestBasicSA;
@property (nonatomic, strong) id requestBasicHL;
@property (nonatomic, strong) id requestBasicHLPct;
@property (nonatomic, strong) id requestSmoker;
@property (nonatomic, strong) id request2ndSmoker;
@property (nonatomic, strong) id requestPayorSmoker;
@property (nonatomic, strong) id requestOccpCPA;
@property (nonatomic, strong) id requestBumpMode;
@property (nonatomic,strong) id requesteProposalStatus;
@property (nonatomic,strong) id SimpleOrDetail;
//

@property (nonatomic,strong) NSString *getSINo;
@property (nonatomic,strong) NSString *getPlanCode;
@property (nonatomic, assign,readwrite) int getAge;
@property (nonatomic,strong) NSString *getSex;
@property (nonatomic,strong) NSString *getOccpCode;
@property (nonatomic, assign,readwrite) int getOccpClass;
@property (nonatomic, assign,readwrite) int getTerm;
@property (nonatomic,strong) NSString *getBUMPMode;
@property (nonatomic, assign,readwrite) double getBasicSA;
@property (nonatomic, assign,readwrite) double getBasicHL;
@property (nonatomic, assign,readwrite) double getBasicHLPct;
@property (nonatomic,strong) NSString *getSmoker;
@property (nonatomic,strong) NSString *get2ndSmoker;
@property (nonatomic,strong) NSString *getPayorSmoker;
@property (nonatomic,strong) NSString *getOccpCPA;

//


@property (weak, nonatomic) IBOutlet UIButton *outletPersonType;
@property (weak, nonatomic) IBOutlet UIButton *outletRider;
@property (weak, nonatomic) IBOutlet UITextField *txtRiderTerm;
@property (weak, nonatomic) IBOutlet UIButton *outletRiderPlan;
@property (weak, nonatomic) IBOutlet UIButton *ActionRiderPlan;
@property (weak, nonatomic) IBOutlet UITextField *txtPaymentTerm;
@property (weak, nonatomic) IBOutlet UIButton *outletDeductible;
@property (weak, nonatomic) IBOutlet UITextField *txtReinvestment;
@property (weak, nonatomic) IBOutlet UITextField *txtRRTUP;
@property (weak, nonatomic) IBOutlet UITextField *txtRRTUPTerm;
@property (weak, nonatomic) IBOutlet UITextField *txtSumAssured;
@property (weak, nonatomic) IBOutlet UITextField *txtGYIFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtOccpLoad;
@property (weak, nonatomic) IBOutlet UITextField *txtHL;
@property (weak, nonatomic) IBOutlet UITextField *txtHLTerm;
@property (weak, nonatomic) IBOutlet UITextField *txtRiderPremium;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;
@property (weak, nonatomic) IBOutlet UILabel *lbl5;
@property (weak, nonatomic) IBOutlet UILabel *lbl6;
@property (weak, nonatomic) IBOutlet UILabel *lbl7;
@property (weak, nonatomic) IBOutlet UILabel *lbl8;
@property (weak, nonatomic) IBOutlet UILabel *lblRegular1;
@property (weak, nonatomic) IBOutlet UILabel *lblRegular2;
@property (weak, nonatomic) IBOutlet UILabel *lblRegularTerm;
@property (weak, nonatomic) IBOutlet UILabel *lblRegularTerm2;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *lblTable1;
@property (weak, nonatomic) IBOutlet UILabel *lblTable2;
@property (weak, nonatomic) IBOutlet UILabel *lblTable3;
@property (weak, nonatomic) IBOutlet UILabel *lblTable4;
@property (weak, nonatomic) IBOutlet UILabel *lblTable5;
@property (weak, nonatomic) IBOutlet UILabel *lblTable6;
@property (weak, nonatomic) IBOutlet UILabel *lblTable7;
@property (weak, nonatomic) IBOutlet UILabel *lblTable8;
@property (weak, nonatomic) IBOutlet UILabel *lblTable9;
@property (weak, nonatomic) IBOutlet UILabel *lblTable10;
@property (weak, nonatomic) IBOutlet UILabel *lblTable11;
@property (weak, nonatomic) IBOutlet UIButton *outletDelete;
@property (weak, nonatomic) IBOutlet UIButton *outletEdit;
@property (weak, nonatomic) IBOutlet UILabel *lblMax;
@property (weak, nonatomic) IBOutlet UILabel *lblMin;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletReinvest;
@property (weak, nonatomic) IBOutlet UILabel *lblHLP;
@property (weak, nonatomic) IBOutlet UITextField *txtHLP;
@property (weak, nonatomic) IBOutlet UILabel *lblHLPTerm;
@property (weak, nonatomic) IBOutlet UITextField *txtHLPTerm;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletDone;
@property (weak, nonatomic) IBOutlet UIButton *OutletAddRider;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletEAPP;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletSpace;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletSegBottomLeft;
- (IBAction)ActionSegBottomLeft:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletSegBottomRight;
- (IBAction)ActionSegBottomRight:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletOccLoading;
- (IBAction)ActionOccLoading:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletCheckBox1;
@property (weak, nonatomic) IBOutlet UIButton *outletCheckBox2;

- (IBAction)ActionCheckBox1:(id)sender;

- (IBAction)ActionCheckbox2:(id)sender;


- (IBAction)ActionEAPP:(id)sender;

- (IBAction)ActionDelete:(id)sender;
- (IBAction)ActionEdit:(id)sender;
- (IBAction)ActionSave:(id)sender;
- (IBAction)ActionDeductible:(id)sender;
- (IBAction)ActionRider:(id)sender;
- (IBAction)ActionPersonType:(id)sender;
- (IBAction)ActionPlan:(id)sender;
- (IBAction)ActionReinvest:(id)sender;
- (IBAction)ActionAddRider:(id)sender;

//get from popover
@property (nonatomic,copy) NSString *pTypeCode;
@property (nonatomic, assign,readwrite) int PTypeSeq;
@property (nonatomic,copy) NSString *pTypeDesc;
@property (nonatomic, assign,readwrite) int pTypeAge;
@property (nonatomic,copy) NSString *pTypeOccp;
@property (nonatomic,copy) NSString *riderCode;
@property (nonatomic,copy) NSString *riderDesc;
@property (nonatomic,copy) NSString *pTypeSex;

//setup form field
@property(nonatomic , retain) NSMutableArray *FLabelCode;
@property(nonatomic , retain) NSMutableArray *FLabelDesc;
@property(nonatomic , retain) NSMutableArray *FRidName;
@property(nonatomic , retain) NSMutableArray *FInputCode;
@property(nonatomic , retain) NSMutableArray *FTbName;
@property(nonatomic , retain) NSMutableArray *FFieldName;
@property(nonatomic , retain) NSMutableArray *FCondition;

@property (nonatomic,strong) NSString *planCondition;
@property (nonatomic,strong) NSString *deducCondition;
@property (nonatomic, assign,readwrite) int expAge;
@property (nonatomic, assign,readwrite) int minSATerm;
@property (nonatomic, assign,readwrite) int maxSATerm;
@property (nonatomic, assign,readwrite) int minTerm;
@property (nonatomic, assign,readwrite) int maxTerm;
@property (nonatomic, assign,readwrite) double maxRiderTerm;
@property (nonatomic, assign,readwrite) double maxRiderSA;
@property (nonatomic, assign,readwrite) double _maxRiderSA;
@property (nonatomic, assign,readwrite) double inputSA;
@property (nonatomic,strong) NSString *planOption;
@property (nonatomic,strong) NSString *deductible;
@property (nonatomic,strong) NSString *inputHL1KSA;
@property (nonatomic,assign,readwrite) int inputHL1KSATerm;
@property (nonatomic,strong) NSString *inputHL100SA;
@property (nonatomic,assign,readwrite) int inputHL100SATerm;
@property (nonatomic,strong) NSString *inputHLPercentage;
@property (nonatomic,assign,readwrite) int inputHLPercentageTerm;
@property(nonatomic , retain) NSMutableArray *atcRidCode;
@property(nonatomic , retain) NSMutableArray *atcPlanChoice;
@property (nonatomic,strong) NSString *existRidCode;
@property (nonatomic,strong) NSString *secondLARidCode;
@property (nonatomic,strong) NSString *payorRidCode;
@property (nonatomic, assign,readwrite) int GYI;
@property (nonatomic, assign,readwrite) int occLoad;
@property(nonatomic , assign,readwrite) int occCPA_PA;
@property (nonatomic, assign,readwrite) int occLoadRider;
@property (nonatomic,strong) NSString *occLoadType;
@property (nonatomic, assign,readwrite) int occClass;
@property(nonatomic , assign,readwrite) int occPA;
@property (nonatomic, assign,readwrite) int occCPA;
@property (nonatomic, assign,readwrite) int storedMaxTerm;
@property (nonatomic, assign,readwrite) int basicRate;
@property (nonatomic, assign,readwrite) int LSDRate;

@property (retain, nonatomic) NSMutableArray *LRiderCode;
@property (retain, nonatomic) NSMutableArray *LSumAssured;
@property (retain, nonatomic) NSMutableArray *LRiderPType;
@property (retain, nonatomic) NSMutableArray *LRiderPTypeSeq;
@property (retain, nonatomic) NSMutableArray *LTerm;
@property (retain, nonatomic) NSMutableArray *LPlanOpt;
@property (retain, nonatomic) NSMutableArray *LUnits;
@property(nonatomic , retain) NSMutableArray *LDeduct;
@property(nonatomic , retain) NSMutableArray *LOccpCode;
@property(nonatomic , retain) NSMutableArray *LRidHL1K;
@property(nonatomic , retain) NSMutableArray *LRidHLTerm;
@property(nonatomic , retain) NSMutableArray *LRidHL100;
@property(nonatomic , retain) NSMutableArray *LRidHL100Term;
@property(nonatomic , retain) NSMutableArray *LRidHLP;
@property(nonatomic , retain) NSMutableArray *LRidHLPTerm;
@property(nonatomic , retain) NSMutableArray *LSmoker;
@property(nonatomic , retain) NSMutableArray *LSex;
@property(nonatomic , retain) NSMutableArray *LAge;
@property(nonatomic , retain) NSMutableArray *LPremium;
@property(nonatomic , retain) NSMutableArray *LReinvest;
@property(nonatomic , retain) NSMutableArray *LPaymentTerm;
@property(nonatomic , retain) NSMutableArray *LRRTUOFromYear;
@property(nonatomic , retain) NSMutableArray *LRRTUOYear;
@property(nonatomic , retain) NSMutableArray *LPaymentChoice;
@property(nonatomic , retain) NSMutableArray *LGYIYear;
@property(nonatomic , retain) NSMutableArray *LPreDeductible;
@property(nonatomic , retain) NSMutableArray *LPostDeductible;

@property (retain, nonatomic) NSMutableArray *LTypeRiderCode;
@property (retain, nonatomic) NSMutableArray *LTypeSumAssured;
@property (retain, nonatomic) NSMutableArray *LTypeTerm;
@property (retain, nonatomic) NSMutableArray *LTypePlanOpt;
@property (retain, nonatomic) NSMutableArray *LTypeUnits;
@property(nonatomic , retain) NSMutableArray *LTypeDeduct;
@property(nonatomic , retain) NSMutableArray *LTypeOccpCode;
@property(nonatomic , retain) NSMutableArray *LTypeRidHL1K;
@property(nonatomic , retain) NSMutableArray *LTypeRidHLTerm;
@property(nonatomic , retain) NSMutableArray *LTypeRidHL100;
@property(nonatomic , retain) NSMutableArray *LTypeRidHL100Term;
@property(nonatomic , retain) NSMutableArray *LTypeRidHLP;
@property(nonatomic , retain) NSMutableArray *LTypeRidHLPTerm;
@property(nonatomic , retain) NSMutableArray *LTypeSmoker;
@property(nonatomic , retain) NSMutableArray *LTypeSex;
@property(nonatomic , retain) NSMutableArray *LTypeAge;
@property(nonatomic , retain) NSMutableArray *LTypePremium;
@property(nonatomic , retain) NSMutableArray *LTypeReinvest;
@property(nonatomic , retain) NSMutableArray *LTypePaymentTerm;
@property(nonatomic , retain) NSMutableArray *LTypeRRTUOFromYear;
@property(nonatomic , retain) NSMutableArray *LTypeRRTUOYear;
@property(nonatomic , retain) NSMutableArray *LTypePaymentChoice;
@property(nonatomic , retain) NSMutableArray *LTypeGYIYear;
@property(nonatomic , retain) NSMutableArray *LTypePreDeductible;
@property(nonatomic , retain) NSMutableArray *LTypePostDeductible;

@property (nonatomic, assign,readwrite) int age;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic, assign,readwrite) double riderRate;
@property (nonatomic, assign,readwrite) double riderRate2;
@property (nonatomic, assign,readwrite) double riderRate3;
@property (nonatomic, assign,readwrite) int CombNo;
@property (nonatomic, assign,readwrite) int RBBenefit;
@property (nonatomic, assign,readwrite) int RBLimit;
@property (nonatomic, assign,readwrite) int RBGroup;
@property (nonatomic, assign,readwrite) int AllCombNo;
@property (nonatomic,strong) NSString *OccpCat;
@property (nonatomic,strong) NSString *pentaSQL;
@property (nonatomic,strong) NSString *medPentaSQL;
@property (nonatomic,strong) NSString *plnOptC;
@property (nonatomic,strong) NSString *planOptHMM;
@property (nonatomic,strong) NSString *deducHMM;
@property (nonatomic,strong) NSString *planHSPII;
@property (nonatomic,strong) NSString *planMGII;
@property (nonatomic,strong) NSString *planMGIV;
@property (nonatomic,strong) NSString *planCodeRider;
@property (nonatomic,strong) NSString *medPlanCodeRider;
@property (nonatomic,strong) NSString *medRiderCode;
@property (nonatomic,strong) NSString *medPlanOpt;
@property (nonatomic,strong) NSMutableArray *annualRiderPrem;
@property (nonatomic,strong) NSMutableArray *quarterRiderPrem;
@property (nonatomic,strong) NSMutableArray *halfRiderPrem;
@property (nonatomic,strong) NSMutableArray *monthRiderPrem;
@property (nonatomic, assign,readwrite) double annualRiderSum;
@property (nonatomic, assign,readwrite) double halfRiderSum;
@property (nonatomic, assign,readwrite) double quarterRiderSum;
@property (nonatomic, assign,readwrite) double monthRiderSum;
@property (nonatomic,strong) NSMutableArray *arrCombNo;
@property (nonatomic,strong) NSMutableArray *arrRBBenefit;





@end
