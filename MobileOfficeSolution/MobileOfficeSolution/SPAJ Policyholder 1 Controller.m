//
//  SPAJ Policy Holder 1 Controller.m
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 11/1/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import "SPAJ Policyholder 1 Controller.h"


// INTERFACE

@interface SPAJPolicyholder1Controller ()

@end


// IMPLEMENTATION

@implementation SPAJPolicyholder1Controller

    /* SYNTHESIZE */

    @synthesize spajPolicyholder1ControllerDelegate = _spajPolicyholder1ControllerDelegate;


    /* VIEW DID LOAD */

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view from its nib.
        
        // DECLARATION
        
        _scrollViewContent.delegate = self;
        
        
        // LOCALIZABLE
        
        _labelSection.text = NSLocalizedString(@"FORM_SECTION_PERSONALINFORMATION", nil);
        
        _labelNumber1.text = @"1";
        _labelQuestionName.text = NSLocalizedString(@"FORM_QUESTION_FULLNAME", nil);
        
        _labelNumber2.text = @"2";
        _labelQuestionSex.text = NSLocalizedString(@"FORM_QUESTION_SEX", nil);
        _labelQuestionBirthPlace.text = NSLocalizedString(@"FORM_QUESTION_BIRTHPLACE", nil);
        _labelQuestionBirthDate.text = NSLocalizedString(@"FORM_QUESTION_BIRTHDATE", nil);
        
        _labelNumber3.text = @"3";
        _labelQuestionIDType.text = NSLocalizedString(@"FORM_QUESTION_IDTYPE", nil);
        _labelQuestionIDNumber.text = NSLocalizedString(@"FORM_QUESTION_IDNUMBER", nil);
        
        _labelNumber4.text = @"4";
        _labelQuestionMaritalStatus.text = NSLocalizedString(@"FORM_QUESTION_MARITALSTATUS", nil);
        
        _labelNumber5.text = @"5";
        _labelQuestionNationality.text = NSLocalizedString(@"FORM_QUESTION_NATIONALITY", nil);
        
        _labelNumber6.text = @"6";
        _labelQuestionReligion.text = NSLocalizedString(@"FORM_QUESTION_RELIGION", nil);
        
        _labelNumber7.text = @"7";
        _labelQuestionHandphone1.text = NSLocalizedString(@"FORM_QUESTION_HANDPHONE1", nil);
        _labelQuestionHandphone2.text = NSLocalizedString(@"FORM_QUESTION_HANDPHONE2", nil);
        _labelQuestionEmail.text = NSLocalizedString(@"FORM_QUESTION_EMAIL", nil);
        
        [_buttonNext setTitle:NSLocalizedString(@"BUTTON_NEXT", nil) forState:UIControlStateNormal];
    }


    /* DID RECEIVE MEMORY WARNING */

    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }


    /* SCROLL VIEW */

    - (void) scrollViewDidEndDecelerating: (UIScrollView *) scrollView
    {
        [_spajPolicyholder1ControllerDelegate headerShowByScroll:scrollView.bounds.size.height intScrollOffsetCurrent:scrollView.contentOffset.y];
    }

@end
