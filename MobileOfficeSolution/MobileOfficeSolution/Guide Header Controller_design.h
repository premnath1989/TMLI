//
//  Guide Header.h
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/31/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Label.h"
#import "Button.h"
#import "Layout.h"
#import "Input.h"
#import "Image.h"


// PROTOCOL

@protocol GuideHeaderControllerDelegate

    - (void) generateGuideDetail: (NSString*) stringStep intStateCurrent: (int) intStateCurrent intStateComplete: (int) intStateComplete;

    - (void) generateForm;

@end


// INTERFACE

@interface GuideHeaderController_design : UIViewController

    /* PROTOCOL */

    @property (nonatomic,strong) id <GuideHeaderControllerDelegate> guideHeaderControllerDelegate;

    /* VARIABLE */

    @property (nonatomic, copy, readwrite) NSString *stringTitle, *stringStep;
    @property (nonatomic, assign, readwrite) int intStateCurrent, intStateComplete;
    @property (nonatomic, assign, readwrite) Boolean booleanState;

    - (id)initialize:
                        (NSString*)stringStep
            stringTitle:(NSString*)stringTitle
        intStateCurrent:(int)intStateCurrent
        intStateComplete:(int)intStateComplete
            booleanState:(BOOL)booleanState;

    /* LABEL */

    @property (nonatomic, weak) IBOutlet LabelGuideHeaderTitle *labelTitle;
    @property (nonatomic, weak) IBOutlet LabelGuideHeaderState *labelState;
    @property (nonatomic, weak) IBOutlet LabelGuideHeaderStep *labelStep;

    /* PROGRESS VIEW */

    @property (nonatomic, weak) IBOutlet ProgressViewGuideHeader *progressViewState;

    /* VIEW */

    @property (nonatomic, weak) IBOutlet ViewGuideHeader *viewGuideHeader;

    /* BUTTON */

    @property (nonatomic, weak) IBOutlet ButtonMasking *buttonGuideHeader;

    /* IMAGE VIEW */

    @property (nonatomic, weak) IBOutlet ImageViewGuideHeaderStep *imageViewStep;

    /* FUNCTION */

    - (Boolean)refreshView;

@end
