//
//  CustomerProfile.h
//  MPOS
//
//  Created by shawal sapuan on 5/10/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalDetialsViewController.h"
#import "StatusViewController.h"

@interface CustomerProfile : UIViewController <UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,PersonalDetialsViewControllerDelegate,StatusViewControllerDelegate>


@property (nonatomic, strong) StatusViewController *statusPicker;
@property (nonatomic, strong) UIPopoverController *statusPickerPopover;

@property (strong, nonatomic) IBOutlet UILabel *idTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *idNoLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastUpdateLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UITextField *txtIdType;
@property (strong, nonatomic) IBOutlet UITextField *txtIdNo;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletBarButtonItem;

@property (strong, nonatomic) NSMutableArray *clientData;
@property (strong, nonatomic) NSMutableArray *arrName;
@property (strong, nonatomic) NSMutableArray *arrIdNo;
@property (strong, nonatomic) NSMutableArray *arrDate;
@property (strong, nonatomic) NSMutableArray *arrCFFID;
@property (strong, nonatomic) NSMutableArray *arrStatus;
@property (strong, nonatomic) NSMutableArray *arrClientProfileID;
@property (strong, nonatomic) IBOutlet UIButton *deleteEditBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;

- (IBAction)doSearch:(id)sender;
- (IBAction)doReset:(id)sender;
- (IBAction)addNewCFF:(id)sender;
- (IBAction)addNewCFFNew:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *doSearchBtn;
- (IBAction)PerformSearch:(id)sender;
- (IBAction)PerformReset:(id)sender;
- (IBAction)doEdit:(id)sender;
- (IBAction)doCancel:(id)sender;
- (IBAction)doDelete:(id)sender;


//-(void)loadDBData;
- (void)loadDBData:(int)indexNo clientName:(NSString*)clientName clientID:(NSString*)clientID CFFID:(NSString*)CFFID;
- (void)deleteCFF:(NSString *)CFFID;
@property (weak, nonatomic) IBOutlet UIButton *btnStatus;
- (IBAction)doBtnStatus:(id)sender;


@end
