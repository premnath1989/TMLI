//
//  SPAJ Add New Controller.m
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/31/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//
// IMPORT

#import "SPAJ Add New Controller.h"
#import "Descriptor Controller.h"
#import "Navigation Controller.h"
#import "Dimension.h"
#import "Layout.h"
#import "Button.h"
#import "SPAJ Policyholder 1 Controller.h"


// INTERFACE

@interface SPAJAddNewController () <GuideHeaderControllerDelegate, SPAJPolicyholder1ControllerDelegate>

@end


// IMPLEMENTATION

@implementation SPAJAddNewController

    /* VIEW DID LOAD */

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
        
        // DECLARATION
        
        _objectUserInterface = [[UserInterface alloc] init];
        _objectGuideHelper = [[GuideHelper alloc] init];
        
        _arrayGuideHeaderController = [[NSMutableArray alloc] initWithCapacity:5];
        
        _guideHeaderController1 = [[GuideHeaderController alloc] initWithNibName:@"Guide Header View" bundle:nil];
        _guideHeaderController2 = [[GuideHeaderController alloc] initWithNibName:@"Guide Header View" bundle:nil];
        _guideHeaderController3 = [[GuideHeaderController alloc] initWithNibName:@"Guide Header View" bundle:nil];
        _guideHeaderController4 = [[GuideHeaderController alloc] initWithNibName:@"Guide Header View" bundle:nil];
        _guideHeaderController5 = [[GuideHeaderController alloc] initWithNibName:@"Guide Header View" bundle:nil];
        _guideHeaderController6 = [[GuideHeaderController alloc] initWithNibName:@"Guide Header View" bundle:nil];
        
        [_guideHeaderController1 initialize:@"1." stringTitle:NSLocalizedString(@"GUIDE_HEADER_POLICYHOLDER", nil) intStateCurrent:4 intStateComplete:4 booleanState:true];
        [_arrayGuideHeaderController addObject:_guideHeaderController1];
        [_guideHeaderController2 initialize:@"2." stringTitle:NSLocalizedString(@"GUIDE_HEADER_PROSPECTIVEINSURED", nil) intStateCurrent:2 intStateComplete:4 booleanState:true];
        [_arrayGuideHeaderController addObject:_guideHeaderController2];
        [_guideHeaderController3 initialize:@"3." stringTitle:NSLocalizedString(@"GUIDE_HEADER_COMPANY", nil) intStateCurrent:-1 intStateComplete:2 booleanState:true];
        [_arrayGuideHeaderController addObject:_guideHeaderController3];
        [_guideHeaderController4 initialize:@"4." stringTitle:NSLocalizedString(@"GUIDE_HEADER_BENEFICIARIESLIST", nil) intStateCurrent:-1 intStateComplete:2 booleanState:true];
        [_arrayGuideHeaderController addObject:_guideHeaderController4];
        [_guideHeaderController5 initialize:@"5." stringTitle:NSLocalizedString(@"GUIDE_HEADER_PREMIPAYMENT", nil) intStateCurrent:-1 intStateComplete:1 booleanState:true];
        [_arrayGuideHeaderController addObject:_guideHeaderController5];
        [_guideHeaderController6 initialize:@"6." stringTitle:NSLocalizedString(@"GUIDE_HEADER_HEALTHQUESTIONNAIRE", nil) intStateCurrent:-1 intStateComplete:2 booleanState:true];
        [_arrayGuideHeaderController addObject:_guideHeaderController6];
        
        
        // LAYOUT
        
        [_imageViewHeader setImage:[UIImage imageNamed:@"SPAJFormHeader"]];
        
            /* INCLUDE */
            
            NavigationController *viewNavigationController = [[NavigationController alloc] initWithNibName:@"Navigation View" bundle:nil];
            viewNavigationController.view.frame = _viewNavigation.bounds;
            [self addChildViewController:viewNavigationController];
            [self.viewNavigation addSubview:viewNavigationController.view];
        
            /* GUIDE HEADER */
            
            for (int i = 0; i < [_arrayGuideHeaderController count]; i++)
            {
                if ([[_arrayGuideHeaderController objectAtIndex:i] booleanState] == true)
                {
                    ViewGuideHeader *viewGuideHeader = [[ViewGuideHeader alloc] init];
                    [viewGuideHeader setupStyle];
                    [_stackViewGuideHeader addArrangedSubview:viewGuideHeader];
                    
                    GuideHeaderController *viewGuideHeaderController = [[_arrayGuideHeaderController objectAtIndex:i] initWithNibName:@"Guide Header View" bundle:nil];
                    viewGuideHeaderController.view.frame = viewGuideHeader.bounds;
                    viewGuideHeaderController.guideHeaderControllerDelegate = self;
                    [self addChildViewController:viewGuideHeaderController];
                    [viewGuideHeader addSubview:viewGuideHeaderController.view];
                    
                    [viewGuideHeaderController refreshView];
                    
                    if (viewGuideHeaderController.intStateCurrent >= 0 && viewGuideHeaderController.intStateCurrent < viewGuideHeaderController.intStateComplete)
                    {
                        [_objectGuideHelper generatorGuideDetail:viewGuideHeaderController.stringStep intStateCurrent:viewGuideHeaderController.intStateCurrent intStateComplete:viewGuideHeaderController.intStateComplete stackViewGuideDetail:_stackViewGuideDetail];
                    }
                    else
                    {
                        
                    }
                }
                else
                {
                    
                }
            }
        
        SPAJPolicyholder1Controller *viewContentForm = [[SPAJPolicyholder1Controller alloc] initWithNibName:@"SPAJ Policy Holder 1 View" bundle:nil];
        viewContentForm.view.frame = _viewContent.bounds;
        viewContentForm.spajPolicyholder1ControllerDelegate = self;
        [self addChildViewController:viewContentForm];
        [self.viewContent addSubview:viewContentForm.view];
        
        
        // LOCALIZABLE
        
        _labelPhotoHeader.text = NSLocalizedString(@"HEADER_SPAJ_ADDNEW", nil);
        _labelPhotoDetail.text = NSLocalizedString(@"DETAIL_SPAJ_ADDNEW", nil);
        _labelHeaderTitle.text = NSLocalizedString(@"HEADER_SPAJ_ADDNEW", nil);
    }


    /* DID RECEIVE MEMORY WARNING */

    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }


    /* VIEW WILL APPEAR */

    - (void)viewWillAppear:(BOOL)animated
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    }


    /* VIEW WILL DISSAPEAR */

    - (void)viewWillDisappear:(BOOL)animated
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }


    /* IBACTION */

    - (IBAction)navigationShow:(id)sender
    {
        [_objectUserInterface navigationShow:self];
    }

    - (IBAction)headerShowByClick:(id)sender
    {
        [_objectUserInterface headerShowByHidden:_viewHeaderThick viewHeaderThin:_viewHeaderThin];
    }

    - (IBAction)headerShowByGesture:(UIPanGestureRecognizer *)recognizer
    {
        CGPoint translation = [recognizer translationInView:self.view];
        
        [_objectUserInterface headerShowByCoordinateY:_viewHeaderThick viewHeaderThin: _viewHeaderThin intCoordinateYDefault:recognizer.view.center.y intCoordinateYCurrent:recognizer.view.center.y + translation.y];
    }

    - (IBAction)guideHeaderUpdate:(id)sender
    {
        [_objectUserInterface headerShowByHidden:_viewHeaderThick viewHeaderThin: _viewHeaderThin];
    }


    /* FUNCTION */

    - (void)headerShowByScroll: (int) intScrollOffsetPage intScrollOffsetCurrent : (int) intScrollOffsetCurrent
    {
        [_objectUserInterface headerShowByScrollOffset:_viewHeaderThick viewHeaderThin:_viewHeaderThin intScrollOffsetPage:intScrollOffsetPage intScrollOffsetCurrent:intScrollOffsetCurrent];
    }

    /* GUIDE DETAIL */

    - (void) generateGuideDetail:(NSString*) stringStep intStateCurrent: (int) intStateCurrent intStateComplete: (int) intStateComplete
    {
        [_objectGuideHelper generatorGuideDetail:stringStep intStateCurrent:intStateCurrent intStateComplete:intStateComplete stackViewGuideDetail:_stackViewGuideDetail];
    }

    - (void) generateForm
    {
        
    }


    /* KEYBOARD */

    - (void) keyboardShow: (NSNotification *) notificationKeyboard
    {
        [_objectUserInterface keyboardShow:notificationKeyboard viewMain:_viewMain];
    }

    - (void) keyboardHide: (NSNotification *) notificationKeyboard
    {
        [_objectUserInterface keyboardHide:notificationKeyboard viewMain:_viewMain];
    }

@end
