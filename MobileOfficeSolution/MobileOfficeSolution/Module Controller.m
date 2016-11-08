//
//  Module Controller.m
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 11/4/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import "Module Controller.h"


// INTERFACE

@interface ModuleController ()

@end


// IMPLEMENTATION

@implementation ModuleController

    /* SYNTHESIZE */

    @synthesize moduleControllerDelegate = moduleControllerDelegate;

    /* INITIALIZE */

    - (id)initialize:(NSString *)stringTitle stringHeader1:(NSString *)stringHeader1 stringDetail1:(NSString *)stringDetail1 stringHeader2:(NSString *)stringHeader2 stringDetail2:(NSString *)stringDetail2 intStateCurrent:(int)intStateCurrent intStateComplete:(int)intStateComplete booleanDetail: (BOOL) booleanDetail booleanState:(BOOL)booleanState
    {
        if ([super init])
        {
            _stringTitle = stringTitle;
            _stringHeader1 = stringHeader1;
            _stringDetail1 = stringDetail1;
            _stringHeader2 = stringHeader2;
            _stringDetail2 = stringDetail2;
            _intStateCurrent = intStateCurrent;
            _intStateComplete = intStateComplete;
            _booleanState = booleanState;
            _booleanDetail = booleanDetail;
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
        
        _labelTitle.text = _stringTitle;
        // _labelProgress.text = [NSString stringWithFormat:@"%i %@", (int)100 / (int)(_intStateCurrent + 1), @"%"];
        
        if (_booleanDetail == true)
        {
            _stackViewModuleDetail.hidden = false;
            _labelHeader1.text = _stringHeader1;
            _labelDetail1.text = _stringDetail1;
            _labelHeader2.text = _stringHeader2;
            _labelDetail2.text = _stringDetail2;
        }
        else
        {
            _stackViewModuleDetail.hidden = true;
        }
        
        if (_intStateCurrent == -1)
        {
            [_viewModule styleDisable];
            [_labelTitle styleDisable];
            [_labelHeader1 styleDisable];
            [_labelDetail1 styleDisable];
            [_labelHeader2 styleDisable];
            [_labelDetail2 styleDisable];
            [_labelProgress styleDisable];
            [_imageViewStep styleDisable];
            booleanComplete = false;
        }
        else if (_intStateCurrent >= 0 && _intStateCurrent < _intStateComplete)
        {
            [_viewModule styleOnProgress];
            [_labelTitle styleOnProgress];
            [_labelHeader1 styleOnProgress];
            [_labelDetail1 styleOnProgress];
            [_labelHeader2 styleOnProgress];
            [_labelDetail2 styleOnProgress];
            [_labelProgress styleOnProgress];
            [_imageViewStep styleOnProgress];
            booleanComplete = false;
        }
        else if (_intStateCurrent == _intStateComplete)
        {
            [_viewModule styleComplete];
            [_labelTitle styleComplete];
            [_labelHeader1 styleComplete];
            [_labelDetail1 styleComplete];
            [_labelHeader2 styleComplete];
            [_labelDetail2 styleComplete];
            [_labelProgress styleComplete];
            [_imageViewStep styleComplete];
            booleanComplete = true;
        }
        else
        {
            [_viewModule styleDisable];
            [_labelTitle styleDisable];
            [_labelHeader1 styleDisable];
            [_labelDetail1 styleDisable];
            [_labelHeader2 styleDisable];
            [_labelDetail2 styleDisable];
            [_labelProgress styleDisable];
            [_imageViewStep styleDisable];
            booleanComplete = false;
        }
        
        return booleanComplete;
    }

@end
