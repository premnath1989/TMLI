//
//  Navigation Controller.m
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/29/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import "Navigation Controller.h"
#import "SettingUserProfile.h"
#import "ProductInformation.h"


// INTERFACE

@interface NavigationController ()

@end


// IMPLEMENTATION

@implementation NavigationController

    /* VIEW DID LOAD */

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [self.view addGestureRecognizer:gr];
        
        // DECLARATION
        
        _objectUserInterface = [[UserInterface alloc] init];
        _storyboardMain = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _storyboardSPAJ = [UIStoryboard storyboardWithName:@"SPAJ" bundle:nil];
        
        
        // LOCALIZABLE
        LoginDBManagement *loginDB = [[LoginDBManagement alloc]init];
        
        NSMutableDictionary *agentDetails =[loginDB getAgentDetails];
        
        NSString *fullName;
        if([agentDetails valueForKey:@"LGIVNAME"] == nil){
            fullName = [NSString stringWithFormat:@"%@ %@",[agentDetails valueForKey:@"AgentName"], @""];
        }else{
            fullName = [NSString stringWithFormat:@"%@ %@", [agentDetails valueForKey:@"LGIVNAME"],[agentDetails valueForKey:@"AgentName"]];
        }
        
        _labelName.text = fullName;
        _labelPosition.text = [loginDB getAgentProperty:@"Level"];
        
            /* NAVIGATION HEADER */
            
            [_buttonHeaderProspect setTitle:NSLocalizedString(@"NAVIGATION_DETAIL_PROSPECT", nil) forState:UIControlStateNormal];
            [_buttonHeaderCalendar setTitle:NSLocalizedString(@"NAVIGATION_HEADER_CALENDAR", nil) forState:UIControlStateNormal];
            [_buttonHeaderSales setTitle:NSLocalizedString(@"NAVIGATION_HEADER_SALES", nil) forState:UIControlStateNormal];
            [_buttonHeaderEPayment setTitle:NSLocalizedString(@"NAVIGATION_HEADER_EPAYMENT", nil) forState:UIControlStateNormal];
            [_buttonHeaderELibrary setTitle:NSLocalizedString(@"NAVIGATION_HEADER_ELIBRARY", nil) forState:UIControlStateNormal];
            [_buttonHeaderReport setTitle:NSLocalizedString(@"NAVIGATION_HEADER_REPORT", nil) forState:UIControlStateNormal];
            [_buttonHeaderActivityManagement setTitle:NSLocalizedString(@"NAVIGATION_HEADER_ACTIVITYMANAGEMENT", nil) forState:UIControlStateNormal];
            
            /* NAVIGATION DETAIL */
            
            [_buttonDetailProspect setTitle:NSLocalizedString(@"NAVIGATION_DETAIL_PROSPECT", nil) forState:UIControlStateNormal];
            [_buttonDetailFNA setTitle:NSLocalizedString(@"NAVIGATION_DETAIL_FNA", nil) forState:UIControlStateNormal];
            [_buttonDetailSI setTitle:NSLocalizedString(@"NAVIGATION_DETAIL_SI", nil) forState:UIControlStateNormal];
            [_buttonDetailSPAJ setTitle:NSLocalizedString(@"NAVIGATION_DETAIL_SPAJ", nil) forState:UIControlStateNormal];
            [_buttonDetailPolicyReceipt setTitle:NSLocalizedString(@"NAVIGATION_DETAIL_POLICYRECEIPT", nil) forState:UIControlStateNormal];
    }

    - (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
        NSLog(@"got a tap on navigation, but not where i need it");
    }

    /* DID RECEIVE MEMORY WARNING */

    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

    /* IBACTION */

    - (IBAction)navigationExpandSales:(id)sender
    {
        [_objectUserInterface navigationExpand:_stackViewSales imageViewNavigationExpand:_imageViewExpandSales];
    }

        /* PROFILE */

        - (IBAction)goToHome: (id) sender
        {
            [self presentViewController:[_storyboardMain instantiateViewControllerWithIdentifier:@"HomePage"] animated:YES completion: nil];
        }

        - (IBAction)goToLogin: (id) sender
        {
            [self presentViewController:[_storyboardMain instantiateViewControllerWithIdentifier:@"LoginPage"] animated:YES completion: nil];
        }

        - (IBAction)goToELibrary:(id)sender {
            
            ProductInformation *view = [[ProductInformation alloc] initWithNibName:@"ProductInformation" bundle:nil];
            view.modalTransitionStyle = UIModalPresentationFullScreen;
            [self presentViewController:view animated:NO completion:nil];
        }

        - (IBAction)goToAgentProfile:(id)sender
        {
            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:Nil];
            SettingUserProfile * UserProfileView = [mainStoryBoard instantiateViewControllerWithIdentifier:@"AgentProfilePage"];
            UserProfileView.modalPresentationStyle = UIModalPresentationFullScreen;
            UserProfileView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            UserProfileView.getLatest = @"Yes";
            [self presentViewController:UserProfileView animated:YES completion:nil];
        }


        /* NAVIGATION */

        - (IBAction)goToSPAJLanding: (id) sender
        {
            [self presentViewController:[_storyboardSPAJ instantiateViewControllerWithIdentifier:@"SPAJLandingPage"] animated:YES completion: nil];
        }

        /* NAVIGATION */

        - (IBAction)goToProspectLanding: (id) sender
        {
            UIStoryboard *cpStoryboard = [UIStoryboard storyboardWithName:@"ProspectProfileStoryboard" bundle:Nil];
            [self presentViewController:[cpStoryboard instantiateViewControllerWithIdentifier:@"ProspectLandingPage"] animated:YES completion: nil];
        }

    - (IBAction)goToSalesIllustration:(id)sender {
        
        UIStoryboard *cpStoryboard = [UIStoryboard storyboardWithName:@"HLAWPStoryboard" bundle:Nil];
        [self presentViewController:[cpStoryboard instantiateViewControllerWithIdentifier:@"SILandingPage"] animated:YES completion: nil];
    
}

@end
