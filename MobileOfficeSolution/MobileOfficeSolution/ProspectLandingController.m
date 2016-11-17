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
#import "MainClient.h"
#import "MainScreen.h"


@interface ProspectLandingController ()

@end

@implementation ProspectLandingController
@synthesize ProspectViewController = _ProspectViewController;



/* VIEW DID LOAD */

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    [_objectUserInterface navigationShow:self];
}


- (IBAction)ActionExisting:(id)sender {
    
    UIStoryboard *cpStoryboard = [UIStoryboard storyboardWithName:@"ProspectProfileStoryboard" bundle:Nil];
    AppDelegate *appdlg = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    MainClient *mainClient = [cpStoryboard instantiateViewControllerWithIdentifier:@"newClientListing"];
    mainClient.modalPresentationStyle = UIModalPresentationFullScreen;
//    mainClient.IndexTab = appdlg.ProspectListingIndex;
    [self presentViewController:mainClient animated:NO completion:Nil];
    appdlg = Nil;
    mainClient= Nil;
}

- (IBAction)ActionAddNew:(id)sender {
    
    UIStoryboard *cpStoryboard = [UIStoryboard storyboardWithName:@"ProspectProfileStoryboard" bundle:Nil];
    AppDelegate *appdlg = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    MainClient *mainClient = [cpStoryboard instantiateViewControllerWithIdentifier:@"Prospect"];
    mainClient.modalPresentationStyle = UIModalPresentationFullScreen;
//    mainClient.IndexTab = appdlg.ProspectListingIndex;
    [self presentViewController:mainClient animated:NO completion:Nil];
    appdlg = Nil;
    mainClient= Nil;
    
    
//    UIStoryboard* clientProfileStoryboard = [UIStoryboard storyboardWithName:@"ProspectProfileStoryboard" bundle:nil];
//    self.ProspectViewController = [clientProfileStoryboard instantiateViewControllerWithIdentifier:@"Prospect"];
//    self.ProspectViewController.delegate = self;
//    [self.navigationController pushViewController:_ProspectViewController animated:YES];
//    _ProspectViewController.navigationItem.title = @"Add New Data Nasabah";
}
@end
