//
//  Guide Header.m
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/31/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import "Guide Header Controller_design.h"


// INTERFACE

@interface GuideHeaderController_design ()

@end


// IMPLEMENTATION

@implementation GuideHeaderController_design

    /* SYNTHESIZE */

    @synthesize guideHeaderControllerDelegate = guideHeaderControllerDelegate;


    /* INITIALIZE */

    - (id)initialize:(NSString *)stringStep stringTitle:(NSString *)stringTitle intStateCurrent:(int)intStateCurrent intStateComplete:(int)intStateComplete booleanState:(BOOL)booleanState
    {
        if ([super init])
        {
            _stringStep = stringStep;
            _stringTitle = stringTitle;
            _intStateCurrent = intStateCurrent;
            _intStateComplete = intStateComplete;
            _booleanState = booleanState;
        }
        else
        {
            
        }
        
        return self;
    }

    /* VIEW DID LOAD */

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
    }

    /* DID RECEIVE MEMORY WARNING */

    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }


    /* FUNCTION */

    - (Boolean) refreshView
    {
        Boolean booleanComplete = false;
        
        _labelStep.text = _stringStep;
        _labelTitle.text = _stringTitle;
        _labelState.text = [NSString stringWithFormat:@"%i %@ %i", _intStateCurrent, NSLocalizedString(@"WORDS_INFIX_OUTOF", nil), _intStateComplete];
        _progressViewState.progress = (float)(_intStateCurrent + 1) / (float)_intStateComplete;
        
        if (_intStateCurrent == -1)
        {
            [_viewGuideHeader styleDisable];
            [_labelStep styleDisable];
            [_labelTitle styleDisable];
            [_labelState styleDisable];
            [_progressViewState styleDisable];
            [_imageViewStep styleDisable];
            booleanComplete = false;
        }
        else if (_intStateCurrent >= 0 && _intStateCurrent < _intStateComplete)
        {
            [_viewGuideHeader styleOnProgress];
            [_labelStep styleOnProgress];
            [_labelTitle styleOnProgress];
            [_labelState styleOnProgress];
            [_progressViewState styleOnProgress];
            [_imageViewStep styleOnProgress];
            booleanComplete = false;
        }
        else if (_intStateCurrent == _intStateComplete)
        {
            [_viewGuideHeader styleComplete];
            [_labelStep styleComplete];
            [_labelTitle styleComplete];
            [_labelState styleComplete];
            [_progressViewState styleComplete];
            [_imageViewStep styleComplete];
            booleanComplete = true;
        }
        else
        {
            [_viewGuideHeader styleDisable];
            [_labelStep styleDisable];
            [_labelTitle styleDisable];
            [_labelState styleDisable];
            [_progressViewState styleDisable];
            [_imageViewStep styleDisable];
            booleanComplete = false;
        }
        
        return booleanComplete;
    }


    /* IBACTION */

    - (IBAction)refreshGuideDetail:(id)sender
    {
        [guideHeaderControllerDelegate generateGuideDetail:_stringStep intStateCurrent:_intStateCurrent intStateComplete:_intStateComplete];
        NSLog(@"refresh guide detail : %@", _stringStep);
        [guideHeaderControllerDelegate generateForm];
    }

@end
