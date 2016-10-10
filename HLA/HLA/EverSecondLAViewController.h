//
//  EverSecondLAViewController.h
//  MPOS
//
//  Created by infoconnect on 6/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ListingTbViewController.h"
#import "DateViewController.h"
#import "OccupationList.h"
#import "AppDelegate.h"

@class EverSecondLAViewController;
@protocol EverSecondLAViewControllerDelegate
-(void) LA2ndIndexNo:(int)aaIndexNo andSmoker:(NSString *)aaSmoker andSex:(NSString *)aaSex andDOB:(NSString *)aaDOB
			  andAge:(int)aaAge andOccpCode:(NSString *)aaOccpCode;
-(void)secondLADelete;
-(void)saved:(BOOL)aaTrue;
-(void) RiderAdded;
-(void)SecondLAGlobalSave;
@end


@interface EverSecondLAViewController : UIViewController<ListingTbViewControllerDelegate,UIPopoverControllerDelegate, DateViewControllerDelegate, OccupationListDelegate, UITextFieldDelegate>{
	NSString *databasePath;
    sqlite3 *contactDB;
    UIPopoverController *popOverController;
    ListingTbViewController *_ProspectList;
	OccupationList *_OccupationList;
    DateViewController *_LADate;
    BOOL useExist;
    BOOL inserted;
    BOOL saved;
	BOOL date1;
	//BOOL isNewClient;
	BOOL QQProspect;
	BOOL Editable;
    BOOL DiffClient;    
    id <EverSecondLAViewControllerDelegate> _delegate;
	AppDelegate *appDel;
}

@property (strong, nonatomic) NSMutableArray *dataInsert;

@property (nonatomic, retain) UIPopoverController *popOverController;
@property (nonatomic, retain) ListingTbViewController *ProspectList;
@property (nonatomic,strong) id <EverSecondLAViewControllerDelegate> delegate;
@property (nonatomic, retain) UIPopoverController *dobPopover;
@property (nonatomic, retain) UIPopoverController *OccupationListPopover;
@property (nonatomic, retain) OccupationList *OccupationList;
@property (nonatomic, retain) DateViewController *LADate;

@property (nonatomic,strong) id EAPPorSI;

//--request
@property (nonatomic, assign,readwrite) int requestLAIndexNo;
@property (nonatomic,strong) id requestSINo;
@property (nonatomic,strong) id requestCommDate;
@property (nonatomic, assign,readwrite) int getLAIndexNo;
@property(nonatomic , retain) NSString *getSINo;
@property (nonatomic, copy) NSString *getCommDate;
@property (nonatomic,strong) id requesteProposalStatus;
//--
-(BOOL)NewDone;
@property (nonatomic, assign,readwrite) int IndexNo;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *smoker;
@property (nonatomic, copy) NSString *DOB;
@property (nonatomic, copy) NSString *jobDesc;
@property (nonatomic, assign,readwrite) int age;
@property (nonatomic, assign,readwrite) int ANB;
@property(nonatomic , retain) NSString *OccpCode;
@property(nonatomic , retain) NSString *occLoading;
@property(nonatomic , assign,readwrite) int occCPA_PA;
@property(nonatomic , assign,readwrite) int occPA;
@property (nonatomic, assign,readwrite) int occuClass;
@property (nonatomic, assign,readwrite) int CustLastNo;
@property(nonatomic , retain) NSString *SINo;
@property (nonatomic, copy) NSString *CustDate;
@property (nonatomic, copy) NSString *CustCode;
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, assign,readwrite) int clientID;
@property (nonatomic, copy) NSString *OccpDesc;
@property (nonatomic, copy) NSString *CheckRiderCode;
@property (nonatomic, copy) NSString *occuCode;

@property(nonatomic , retain) NSString *NamePP;
@property(nonatomic , retain) NSString *DOBPP;
@property(nonatomic , retain) NSString *GenderPP;
@property(nonatomic , retain) NSString *OccpCodePP;
@property(nonatomic , retain) NSString *SmokerPP;







- (IBAction)ActionEnable:(id)sender;
- (IBAction)ActionDelete:(id)sender;
- (IBAction)ActionGender:(id)sender;
- (IBAction)ActionSmoker:(id)sender;
- (IBAction)btnDone:(id)sender;
- (IBAction)ActionDOB:(id)sender;
- (IBAction)ActionOccpDesc:(id)sender;
- (IBAction)ActionProspect:(id)sender;
- (IBAction)ActionEAPP:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnDOB;
@property (weak, nonatomic) IBOutlet UIButton *btnOccpDesc;
@property (weak, nonatomic) IBOutlet UIButton *outletDelete;
@property (weak, nonatomic) IBOutlet UIButton *btnEnable;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletGender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletSmoker;
@property (weak, nonatomic) IBOutlet UITextField *txtDOB;
@property (weak, nonatomic) IBOutlet UITextField *txtALB;
@property (weak, nonatomic) IBOutlet UITextField *txtOccpDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnProspect;
@property (weak, nonatomic) IBOutlet UITextField *txtOccpLoad;
@property (weak, nonatomic) IBOutlet UITextField *txtCPA;
@property (weak, nonatomic) IBOutlet UITextField *txtPA;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletDone;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletEAPP;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletSpace;


@property(nonatomic , retain) NSString *Change;
@property(nonatomic , retain) NSString *LAView;



@end
