//
//  SILandingScreen.m
//  MobileOfficeSolution
//
//  Created by Premnath on 21/11/2016.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import "SILandingScreen.h"
#import "Descriptor Controller.h"
#import "Navigation Controller.h"
#import "ProspectViewController.h"
#import "Dimension.h"
#import "Button.h"
#import "User Interface.h"
#import "AppDelegate.h"
#import "MainScreen.h"


@interface SILandingScreen ()

@end

@implementation SILandingScreen
@synthesize NewLAViewController = _NewLAViewController;

BOOL NavShowOne;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavShowOne = NO;
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
    
    _labelPhotoHeader.text = NSLocalizedString(@"HEADER_SI_LANDING", nil);
    _labelPhotoDetail.text = NSLocalizedString(@"DETAIL_SPAJ_LANDING", nil);
    
    [_buttonAddNew setTitle:NSLocalizedString(@"BUTTON_PHOTO_ADDNEW", nil) forState:UIControlStateNormal];
    [_buttonExistingList setTitle:NSLocalizedString(@"BUTTON_PHOTO_EXISTINGLIST", nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)navigationShow:(id)sender
{
    if (!NavShowOne) {
        [_objectUserInterface navigationShow:self];
        NavShowOne = YES;
        [self headerShow:_viewTest2 viewHeaderThin : _viewTest1 booleanShow : true];
    }else{
        [_objectUserInterface navigationHide:self];
        [self headerShow:_viewTest2 viewHeaderThin : _viewTest1 booleanShow : false];
        NavShowOne = NO;
    }
    
}

- (IBAction)ActionExisting:(id)sender {
    
//    UIStoryboard *cpStoryboard = [UIStoryboard storyboardWithName:@"HLAWPStoryboard" bundle:Nil];
//    AppDelegate *appdlg = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
//    MainClient *mainClient = [cpStoryboard instantiateViewControllerWithIdentifier:@"SIListing"];
//    mainClient.modalPresentationStyle = UIModalPresentationFullScreen;
//    //    mainClient.IndexTab = appdlg.ProspectListingIndex;
//    [self presentViewController:mainClient animated:NO completion:Nil];
//    appdlg = Nil;
//    mainClient= Nil;
}

- (IBAction)ActionAddNew:(id)sender {
    
//    UIStoryboard *cpStoryboard = [UIStoryboard storyboardWithName:@"HLAWPStoryboard" bundle:Nil];
//    AppDelegate *appdlg = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
//    MainClient *mainClient = [cpStoryboard instantiateViewControllerWithIdentifier:@"SIPageView"];
//    mainClient.modalPresentationStyle = UIModalPresentationFullScreen;
//    //    mainClient.IndexTab = appdlg.ProspectListingIndex;
//    [self presentViewController:mainClient animated:NO completion:Nil];
//    appdlg = Nil;
//    mainClient= Nil;
    
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
