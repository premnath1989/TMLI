//
//  CustomerClientProfile.h
//  MPOS
//
//  Created by Meng Cheong on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerViewController.h"

@interface CustomerClientProfile : UIViewController<UIAlertViewDelegate>{
    CustomerViewController *_CustomerVC;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *DoneBtn;
- (IBAction)doDone:(id)sender;

- (IBAction)doCancel:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *CustomerTitle;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, retain) CustomerViewController *CustomerVC;
@end
