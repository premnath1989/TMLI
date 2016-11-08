//
//  TextFieldPrimary.h
//  Practice
//
//  Created by Ibrahim on 20/05/2016.
//  Copyright © 2016 Ibrahim. All rights reserved.
//


// IMPORT

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User Interface.h"


// TEXTFIELD

    /* FORM */

    @interface TextFieldFormGeneralPrimary : UITextField<UITextFieldDelegate>

        @property (nonatomic, copy, readwrite) UserInterface* objectUserInterface;

        - (void)setupStyle;
        - (void)styleValid;
        - (void)styleInvalid;
        - (void)styleDisable;
        - (void)styleEnable;

    @end

    /* PHOTO */

    @interface TextFieldPhotoGeneralPrimary : UITextField<UITextFieldDelegate>

        @property (nonatomic, copy, readwrite) UserInterface* objectUserInterface;

        - (void)setupStyle;
        - (void)styleValid;
        - (void)styleInvalid;
        - (void)styleDisable;
        - (void)styleEnable;

    @end


// PROGRESS VIEW

@interface ProgressViewGuideHeader : UIProgressView

    @property (nonatomic, copy, readwrite) UserInterface* objectUserInterface;

    - (void)setupStyle;
    - (void)styleOnProgress;
    - (void)styleComplete;
    - (void)styleDisable;

@end


// SEGMENTED CONTROL

@interface SegmentedControlFormGeneralPrimary : UISegmentedControl

    @property (nonatomic, copy, readwrite) UserInterface* objectUserInterface;

    - (void)setupStyle;
    - (void)styleValid;
    - (void)styleInvalid;
    - (void)styleDisable;
    - (void)styleEnable;

@end
