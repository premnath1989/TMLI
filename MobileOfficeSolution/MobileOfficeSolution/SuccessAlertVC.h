//
//  SuccessAlertVC.h
//  MobileOfficeSolution
//
//  Created by Emi on 22/11/16.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccessAlertVC : UIViewController


@property (strong, nonatomic) NSUserDefaults *UDScore;

@property (strong, nonatomic) IBOutlet UIButton *btnOK;
- (IBAction)ActionOK:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblScore;
@property (strong, nonatomic) IBOutlet UILabel *LblTittle;
@property (strong, nonatomic) IBOutlet UILabel *LblGroup;
@property (strong, nonatomic) IBOutlet UIView *ViewScore;


@end
