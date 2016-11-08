//
//  Home Controller.m
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/27/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import "Home Controller.h"
#import "Dimension.h"
#import "Button.h"
#import "User Interface.h"
#import "AppDelegate.h"
#import "MainClient.h"
#import "MainScreen.h"


// INTERFACE

@interface HomeController ()

@end


// IMPLEMENTATION

@implementation HomeController

    /* VIEW DID LOAD */

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
        // DECLARATION
        
        _objectUserInterface = [[UserInterface alloc] init];
        _storyboardMain = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _storyboardSPAJ = [UIStoryboard storyboardWithName:@"SPAJ" bundle:nil];
        
        
        // LAYOUT
        
        _scrollViewSliderNews.delegate = self;
        
        
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
        
        
        // SLIDER
        
        CGRect rectangularScreen = [[UIScreen mainScreen] bounds];
        CGFloat floatScreenWidth = rectangularScreen.size.width;
        CGFloat floatScreenHeight = rectangularScreen.size.height;
        int intScrollViewHeight = floatScreenHeight - SLIDER_HEIGHT_CONTROLLER - PROFILE_HEIGHT_VIEW - GENERAL_SPACE_MEDIUM;
        NSLog(@"intScrollViewHeight : %d", intScrollViewHeight);
        int intScrollViewCoordinateX = 0;
        _scrollViewSliderNews.pagingEnabled = YES;
        _arrayImage = [[NSArray alloc]initWithObjects:@"photo_news1_primary.png", @"photo_news2_primary.png", @"photo_news3_primary.png", nil];
        [_stackViewSliderController.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        
        for (int i = 0; i < _arrayImage.count; i++)
        {
            UIImageView *imageNews = [[UIImageView alloc]initWithFrame:CGRectMake(intScrollViewCoordinateX, 0, floatScreenWidth, intScrollViewHeight)];
            imageNews.image = [UIImage imageNamed:[_arrayImage objectAtIndex:i]];
            [imageNews setContentMode:UIViewContentModeScaleAspectFill];
            intScrollViewCoordinateX = intScrollViewCoordinateX + floatScreenWidth;
            [_scrollViewSliderNews addSubview:imageNews];
            
            ButtonSlider *buttonSliderController = [[ButtonSlider alloc] init];
            [buttonSliderController setupStyle];
            buttonSliderController.tag = i + 10;
            NSLog(@"buttonSliderController : %ld", (long)buttonSliderController.tag);
            [_stackViewSliderController addArrangedSubview:buttonSliderController];
        }
        
        _scrollViewSliderNews.contentSize=CGSizeMake(intScrollViewCoordinateX, intScrollViewHeight);
        _scrollViewSliderNews.contentOffset=CGPointMake(0, 0);
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

    - (void) scrollViewDidScroll: (UIScrollView *) scrollView
    {
        int intButtonSliderControllerTag = (scrollView.contentOffset.x / [[UIScreen mainScreen] bounds].size.width) + 10;
        
        for (int i = 0; i < _arrayImage.count; i++)
        {
            ButtonSlider *buttonSliderControllerSelected = (ButtonSlider *)[_stackViewSliderController viewWithTag:i + 10];
            [buttonSliderControllerSelected styleNotSelected];
        }
        
        ButtonSlider *buttonSliderControllerSelected = (ButtonSlider *)[_stackViewSliderController viewWithTag:intButtonSliderControllerTag];
        [buttonSliderControllerSelected styleSelected];
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

    - (IBAction)goToProspect:(id)sender {
        UIStoryboard *cpStoryboard = [UIStoryboard storyboardWithName:@"ClientProfileStoryboard" bundle:Nil];
        AppDelegate *appdlg = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        MainClient *mainClient = [cpStoryboard instantiateViewControllerWithIdentifier:@"mainClient"];
        mainClient.modalPresentationStyle = UIModalPresentationFullScreen;
        mainClient.IndexTab = appdlg.ProspectListingIndex;
        [self presentViewController:mainClient animated:NO completion:Nil];
        appdlg = Nil;
        mainClient= Nil;
    }

    - (IBAction)goToSalesIllustration:(id)sender {
        // Override option, open the Traditional SI
        UIStoryboard *cpStoryboard = [UIStoryboard storyboardWithName:@"HLAWPStoryboard" bundle:Nil];
        AppDelegate *appdlg = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        MainScreen *mainScreen= [cpStoryboard instantiateViewControllerWithIdentifier:@"Main"];
        mainScreen.tradOrEver = @"TRAD";
        mainScreen.modalPresentationStyle = UIModalPresentationFullScreen;
        mainScreen.IndexTab = appdlg.SIListingIndex;
        [self presentViewController:mainScreen animated:NO completion:Nil];
        mainScreen= Nil;
        appdlg = nil;
    }

@end
