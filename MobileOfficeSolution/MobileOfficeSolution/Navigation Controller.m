//
//  Navigation Controller.m
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/29/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import "Navigation Controller.h"


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
        
        // DECLARATION
        
        _objectUserInterface = [[UserInterface alloc] init];
        _storyboardMain = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _storyboardSPAJ = [UIStoryboard storyboardWithName:@"SPAJ" bundle:nil];
        
        
        // LOCALIZABLE
        
        _labelName.text = @"Andy Phan";
        _labelPosition.text = @"sales executive";
        
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

    /* DID RECEIVE MEMORY WARNING */

    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

    /* IBACTION */

    - (IBAction)navigationExpandSales:(id)sender
    {
        [_objectUserInterface navigationExpand:_stackViewSales];
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

        /* NAVIGATION */

        - (IBAction)goToSPAJLanding: (id) sender
        {
            [self presentViewController:[_storyboardSPAJ instantiateViewControllerWithIdentifier:@"SPAJLandingPage"] animated:YES completion: nil];
        }

@end
