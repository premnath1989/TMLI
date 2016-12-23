//
//  SettingUserProfile.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 11/16/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "DateViewController.h"
#import "AgentWS.h"
#import "LoginDBManagement.h"
#import "SpinnerUtilities.h"

@interface SettingUserProfile : UIViewController <DateViewControllerDelegate, UITextFieldDelegate, NSXMLParserDelegate, AgentWSSoapBindingResponseDelegate>{
    NSString *databasePath;
    sqlite3 *contactDB;
    UITextField *activeField;
    DateViewController *_DatePicker;
    UIPopoverController *_datePopover;
    NSMutableDictionary *agentDetails;
    LoginDBManagement *loginDB;
    SpinnerUtilities *spinnerLoading;
    id temp;
}

@property (nonatomic,strong) id idRequest;
@property (nonatomic, assign) int indexNo;

@property (weak, nonatomic) IBOutlet UITextField *txtAgentCode;
@property (weak, nonatomic) IBOutlet UITextField *txtAgentName;
@property (weak, nonatomic) IBOutlet UITextField *txtAgentLvl;
@property (weak, nonatomic) IBOutlet UITextField *txtAgentStatus;
@property (weak, nonatomic) IBOutlet UITextField *txtJenisKelamin;
@property (weak, nonatomic) IBOutlet UITextField *txtBOD;
@property (weak, nonatomic) IBOutlet UITextField *txtReligion;
@property (weak, nonatomic) IBOutlet UITextField *txtMaritalStatus;
@property (weak, nonatomic) IBOutlet UITextField *txtIDCard;
@property (weak, nonatomic) IBOutlet UITextField *txtLicense;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtBusinessNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextView *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtPTKP;
@property (weak, nonatomic) IBOutlet UITextField *txtNoRek;
@property (weak, nonatomic) IBOutlet UITextField *txtBankName;
@property (weak, nonatomic) IBOutlet UITextField *txtRekName;
@property (weak, nonatomic) IBOutlet UITextField *txtDM;
@property (weak, nonatomic) IBOutlet UITextField *txtRM;
@property (weak, nonatomic) IBOutlet UITextField *txtRD;
@property (weak, nonatomic) IBOutlet UITextField *txtNamaKantor;
@property (weak, nonatomic) IBOutlet UITextField *txtAAJINo;
@property (weak, nonatomic) IBOutlet UITextField *txtAAJIDate;

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *contactNo;
@property (nonatomic, copy) NSString *leaderCode;
@property (nonatomic, copy) NSString *leaderName;
@property (nonatomic, copy) NSString *registerNo;
@property (nonatomic, copy) NSString *email;
@property (weak, nonatomic) IBOutlet UIButton *outletSave;
@property (weak, nonatomic) IBOutlet UIButton *outletChgPassword;
@property (weak, nonatomic) IBOutlet UIButton *outletSyncSPAJNumber;

@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;

- (IBAction)btnClose:(id)sender;
- (IBAction)btnSync:(id)sender;
- (IBAction)btnDone:(id)sender;
- (IBAction)ChangePassword:(id)sender;
- (IBAction)syncSPAJNumber:(id)sender;

//--bob
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutlet UITextField *txtICNo;
@property (strong, nonatomic) IBOutlet UIButton *btnContractDate;
- (IBAction)btnContractDatePressed:(id)sender;

@property (nonatomic, retain) DateViewController *DatePicker;
@property (nonatomic, retain) UIPopoverController *datePopover;
@property (nonatomic, copy) NSString *contDate;
@property (nonatomic, copy) NSString *ICNo;
@property (nonatomic, copy) NSString *Addr1;
@property (nonatomic, copy) NSString *Addr2;
@property (nonatomic, copy) NSString *Addr3;
@property (nonatomic, copy) NSString *AgentPortalLoginID;
@property (nonatomic, copy) NSString *AgentPortalPassword;
@property (nonatomic, copy) NSString *getLatest;
//--end


@end
