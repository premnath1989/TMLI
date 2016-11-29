//
//  ProspectLandingController.m
//  MobileOfficeSolution
//
//  Created by Emi on 15/11/16.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import "ProspectLandingController.h"
#import "Descriptor Controller.h"
#import "Navigation Controller.h"
#import "ProspectViewController.h"
#import "Dimension.h"
#import "Button.h"
#import "User Interface.h"
#import "AppDelegate.h"
#import "MainScreen.h"


@interface ProspectLandingController ()

@end

@implementation ProspectLandingController
@synthesize ProspectViewController = _ProspectViewController;

BOOL NavShow;

/* VIEW DID LOAD */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NavShow = NO;
    // Do any additional setup after loading the view.
    
    // DECLARATION
    _objectUserInterface = [[UserInterface alloc] init];
    
    
    // LAYOUT
    [_imageViewBackground setImage:[UIImage imageNamed:@"photo_spaj_secondary"]];
    
    /* INCLUDE */
    
    DescriptorController *viewDescriptorController = [[DescriptorController alloc] initWithNibName:@"Descriptor View" bundle:nil];
    viewDescriptorController.view.frame = _viewDescriptor.bounds;
    [self addChildViewController:viewDescriptorController];
    [self.viewDescriptor addSubview:viewDescriptorController.view];
    
    NavigationController *viewNavigationController = [[NavigationController alloc] initWithNibName:@"Navigation View" bundle:nil];
    viewNavigationController.view.frame = _viewNavigation.bounds;
    [self addChildViewController:viewNavigationController];
    [self.viewNavigation addSubview:viewNavigationController.view];
    
    
    // LOCALIZABLE
    
    _labelPhotoHeader.text = NSLocalizedString(@"HEADER_PROSPECT_LANDING", nil);
    _labelPhotoDetail.text = NSLocalizedString(@"DETAIL_SPAJ_LANDING", nil);
    
    [_buttonAddNew setTitle:NSLocalizedString(@"BUTTON_PHOTO_ADDNEW", nil) forState:UIControlStateNormal];
    [_buttonExistingList setTitle:NSLocalizedString(@"BUTTON_PHOTO_EXISTINGLIST", nil) forState:UIControlStateNormal];
}


/* DID RECEIVE MEMORY WARNING */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* IBACTION */

- (IBAction)navigationShow:(id)sender
{
    if (!NavShow) {
        [_objectUserInterface navigationShow:self];
        NavShow = YES;
//        [self headerShow:_viewTest2 viewHeaderThin : _viewTest1 booleanShow : true];
    }else{
        [_objectUserInterface navigationHide:self];
//        [self headerShow:_viewTest2 viewHeaderThin : _viewTest1 booleanShow : false];
        NavShow = NO;
    }
    
}


- (IBAction)ActionExisting:(id)sender {
    
    UIStoryboard *cpStoryboard = [UIStoryboard storyboardWithName:@"ProspectProfileStoryboard" bundle:Nil];
    [self presentViewController:[cpStoryboard instantiateViewControllerWithIdentifier:@"newClientListing"] animated:YES completion: nil];
    

}

- (IBAction)ActionAddNew:(id)sender {
    
    UIStoryboard *cpStoryboard = [UIStoryboard storyboardWithName:@"ProspectProfileStoryboard" bundle:Nil];
    [self presentViewController:[cpStoryboard instantiateViewControllerWithIdentifier:@"Prospect"] animated:YES completion: nil];
    
}

-(void) headerShow:(UIView *) viewHeaderThick viewHeaderThin : (UIView *) viewHeaderThin booleanShow : (Boolean) booleanShow
{
    viewHeaderThick.clipsToBounds = true;
    viewHeaderThin.clipsToBounds = true;
    
    if (booleanShow == false)
    {
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView
         animateWithDuration: 0.25
         animations:^
         {
             viewHeaderThick.alpha = 0;
             viewHeaderThick.hidden = true;
             viewHeaderThin.hidden = false;
             viewHeaderThin.alpha = 1;
         }
         completion:^(BOOL finished)
         {
             viewHeaderThick.hidden = true;
             viewHeaderThin.hidden = false;
         }
         ];
        
    }
    else
    {
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView
         animateWithDuration: 0.25
         animations:^
         {
             viewHeaderThick.hidden = false;
             viewHeaderThick.alpha = 1;
             viewHeaderThin.hidden = true;
             viewHeaderThin.alpha = 0;
         }
         completion:^(BOOL finished)
         {
             viewHeaderThick.hidden = false;
             viewHeaderThin.hidden = true;
         }
         ];
    }
}


@end
