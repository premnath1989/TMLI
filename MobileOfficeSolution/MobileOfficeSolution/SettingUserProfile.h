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
#import "User Interface.h"
#import "Navigation Controller.h"

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

@property (weak, nonatomic) IBOutlet UITextField *txtLicense;

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


// BHIMBIM'S QUICK FIX - Start

/* VIEW */

@property (nonatomic, weak) IBOutlet UIView *viewNavigation;
@property (nonatomic, weak) IBOutlet UIView *viewMain;

/* LABEL */

@property (nonatomic, weak) IBOutlet UILabel *labelFormHeader;
@property (nonatomic, weak) IBOutlet UILabel *labelFormDetail;

@property (nonatomic, weak) IBOutlet UILabel *labelProfileInitial;
@property (nonatomic, weak) IBOutlet UILabel *labelProfileName;

@property (nonatomic, weak) IBOutlet UILabel *labelSectionPersonalInformation;
@property (nonatomic, weak) IBOutlet UILabel *labelFormSex;
@property (nonatomic, weak) IBOutlet UILabel *labelFormBirthDate;
@property (nonatomic, weak) IBOutlet UILabel *labelFormReligion;
@property (nonatomic, weak) IBOutlet UILabel *labelFormMaritalStatus;
@property (nonatomic, weak) IBOutlet UILabel *labelFormIDNumber;
@property (nonatomic, weak) IBOutlet UILabel *labelFormPTKPStatus;
@property (nonatomic, weak) IBOutlet UILabel *labelFormBankName;
@property (nonatomic, weak) IBOutlet UILabel *labelFormAccountNumber;
@property (nonatomic, weak) IBOutlet UILabel *labelFormAccountHolder;
@property (nonatomic, weak) IBOutlet UILabel *labelFormNPWP;

@property (nonatomic, weak) IBOutlet UILabel *labelSectionContact;
@property (nonatomic, weak) IBOutlet UILabel *labelFormAddress;
@property (nonatomic, weak) IBOutlet UILabel *labelFormHandphoneHome;
@property (nonatomic, weak) IBOutlet UILabel *labelFormHandphoneBusiness;
@property (nonatomic, weak) IBOutlet UILabel *labelFormEmail;

@property (nonatomic, weak) IBOutlet UILabel *labelSectionStructure;
@property (nonatomic, weak) IBOutlet UILabel *labelFormDistrictManager;
@property (nonatomic, weak) IBOutlet UILabel *labelFormRegionalManager;
@property (nonatomic, weak) IBOutlet UILabel *labelFormRegionalDirector;

@property (nonatomic, weak) IBOutlet UILabel *labelSectionAgent;
@property (nonatomic, weak) IBOutlet UILabel *labelFormOfficeName;
@property (nonatomic, weak) IBOutlet UILabel *labelFormAAJILicense;
@property (nonatomic, weak) IBOutlet UILabel *labelFormAAJIExpiredDate;

/* TEXTFIELD */

@property (nonatomic, weak) IBOutlet UITextField *textFieldProfileID;
@property (nonatomic, weak) IBOutlet UITextField *textFieldProfileLevel;
@property (nonatomic, weak) IBOutlet UITextField *textFieldProfileStatus;

@property (nonatomic, weak) IBOutlet UITextField *textFieldFormSex;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormBirthDate;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormReligion;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormMaritalStatus;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormIDNumber;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormPTKPStatus;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormBankName;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormAccountNumber;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormAccountHolder;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormNPWP;

@property (nonatomic, weak) IBOutlet UITextField *textFieldFormAddress;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormHandphoneHome;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormHandphoneBusiness;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormEmail;

@property (nonatomic, weak) IBOutlet UITextField *textFieldFormDistrictManager;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormRegionalManager;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormRegionalDirector;

@property (nonatomic, weak) IBOutlet UITextField *textFieldFormOfficeName;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormAAJILicense;
@property (nonatomic, weak) IBOutlet UITextField *textFieldFormAAJIExpiredDate;

/* BUTTON */

@property (nonatomic, weak) IBOutlet UIButton *buttonChangePassword;
@property (nonatomic, weak) IBOutlet UIButton *buttonSync;

/* OBJECT */

@property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

// BHIMBIM'S QUICK FIX - End



@end
