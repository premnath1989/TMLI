//
//  SILandingScreen.h
//  MobileOfficeSolution
//
//  Created by Premnath on 21/11/2016.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "User Interface.h"
#import "NewLAViewController.h"


@interface SILandingScreen : UIViewController <NewLAViewControllerDelegate>
{
    NewLAViewController * _NewLAViewcontroller;
}

@property (nonatomic, retain) NewLAViewController *NewLAViewController;

/* VIEW */

@property (nonatomic, weak) IBOutlet UIView *viewDescriptor;
@property (nonatomic, weak) IBOutlet UIView *viewNavigation;
@property (nonatomic, weak) IBOutlet UIView *viewMain;

@property (nonatomic, weak) IBOutlet UIView *viewTest1;
@property (nonatomic, weak) IBOutlet UIView *viewTest2;


/* IMAGE VIEW */

@property (nonatomic, weak) IBOutlet UIImageView *imageViewBackground;

/* LABEL */

@property (nonatomic, weak) IBOutlet UILabel *labelPhotoHeader;
@property (nonatomic, weak) IBOutlet UILabel *labelPhotoDetail;

/* BUTTON */

@property (nonatomic, weak) IBOutlet UIButton *buttonAddNew;
@property (nonatomic, weak) IBOutlet UIButton *buttonExistingList;
@property (nonatomic, weak) IBOutlet UIButton *buttonNavigation;

/* OBJECT */

@property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;
- (IBAction)ActionExisting:(id)sender;
- (IBAction)ActionAddNew:(id)sender;


@end

