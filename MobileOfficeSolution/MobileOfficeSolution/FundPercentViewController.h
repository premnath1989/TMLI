//
//  FundPercentViewController.h
//  MobileOfficeSolution
//
//  Created by Emi on 6/1/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundPercentViewController : UIViewController

@property (strong, nonatomic) NSUserDefaults *UDInvest;
@property (strong, nonatomic) IBOutlet UILabel *lblFundName;
@property (strong, nonatomic) IBOutlet UITextField *TxtPercentage;

@property (strong, nonatomic) NSMutableArray *InvestList;

- (IBAction)ActionOK:(id)sender;
- (IBAction)ActionCancel:(id)sender;

@end
