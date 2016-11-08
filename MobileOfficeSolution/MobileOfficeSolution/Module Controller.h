//
//  Module Controller.h
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 11/4/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Label.h"
#import "Image.h"
#import "Layout.h"
#import "Button.h"


// PROTOCOL

@protocol moduleControllerDelegate

    - (void) goToSPAJAddNew;

@end


// INTERFACE

@interface ModuleController : UIViewController

    /* PROTOCOL */

    @property (nonatomic,strong) id <moduleControllerDelegate> moduleControllerDelegate;

    /* VARIABLE */

    @property (nonatomic, copy, readwrite) NSString *stringTitle, *stringHeader1, *stringDetail1, *stringHeader2, *stringDetail2;
    @property (nonatomic, assign, readwrite) int intStateCurrent, intStateComplete;
    @property (nonatomic, assign, readwrite) Boolean booleanDetail, booleanState;

    - (id)initialize:
        (NSString*)stringTitle
        stringHeader1:(NSString*)stringHeader1
        stringDetail1:(NSString*)stringDetail1
        stringHeader2:(NSString*)stringHeader2
        stringDetail2:(NSString*)stringDetail2
        intStateCurrent:(int)intStateCurrent
        intStateComplete:(int)intStateComplete
        booleanDetail:(BOOL)booleanDetail
        booleanState:(BOOL)booleanState;

    /* LABEL */

    @property (nonatomic, weak) IBOutlet LabelModuleTitle *labelTitle;
    @property (nonatomic, weak) IBOutlet LabelModuleHeader *labelHeader1;
    @property (nonatomic, weak) IBOutlet LabelModuleDetail *labelDetail1;
    @property (nonatomic, weak) IBOutlet LabelModuleHeader *labelHeader2;
    @property (nonatomic, weak) IBOutlet LabelModuleDetail *labelDetail2;
    @property (nonatomic, weak) IBOutlet LabelModuleProgress *labelProgress;

    /* VIEW */

    @property (nonatomic, weak) IBOutlet ViewModule *viewModule;

    /* BUTTON */

    @property (nonatomic, weak) IBOutlet ButtonMasking *buttonGuideHeader;

    /* IMAGE VIEW */

    @property (nonatomic, weak) IBOutlet ImageViewGuideHeaderStep *imageViewStep;

    /* VIEW */

    @property (nonatomic, weak) IBOutlet StackViewModuleDetail *stackViewModuleDetail;

    /* FUNCTION */

    - (Boolean)refreshView;

@end
