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

    @interface TextFieldFormGeneralSecondary : UITextField<UITextFieldDelegate>

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


// DROPDOWN

    /* FORM */

    @interface DropdownFormGeneralPrimary : UITextField<UITextFieldDelegate>

        @property (nonatomic, copy, readwrite) UserInterface* objectUserInterface;

        - (void)setupStyle;
        - (void)styleValid;
        - (void)styleInvalid;
        - (void)styleDisable;
        - (void)styleEnable;

    @end

    @interface DropdownFormGeneralSecondary : UITextField<UITextFieldDelegate>

        @property (nonatomic, copy, readwrite) UserInterface* objectUserInterface;

        - (void)setupStyle;
        - (void)styleValid;
        - (void)styleInvalid;
        - (void)styleDisable;
        - (void)styleEnable;

    @end

    /* PHOTO */

    @interface DropdownPhotoGeneralPrimary : UITextField<UITextFieldDelegate>

        @property (nonatomic, copy, readwrite) UserInterface* objectUserInterface;

        - (void)setupStyle;
        - (void)styleValid;
        - (void)styleInvalid;
        - (void)styleDisable;
        - (void)styleEnable;

    @end


// DATE

    /* FORM */

    @interface DateFormGeneralPrimary : UITextField<UITextFieldDelegate>

        @property (nonatomic, copy, readwrite) UserInterface* objectUserInterface;

        - (void)setupStyle;
        - (void)styleValid;
        - (void)styleInvalid;
        - (void)styleDisable;
        - (void)styleEnable;

    @end

    @interface DateFormGeneralSecondary : UITextField<UITextFieldDelegate>

        @property (nonatomic, copy, readwrite) UserInterface* objectUserInterface;

        - (void)setupStyle;
        - (void)styleValid;
        - (void)styleInvalid;
        - (void)styleDisable;
        - (void)styleEnable;

    @end

    /* PHOTO */

    @interface DatePhotoGeneralPrimary : UITextField<UITextFieldDelegate>

        @property (nonatomic, copy, readwrite) UserInterface* objectUserInterface;

        - (void)setupStyle;
        - (void)styleValid;
        - (void)styleInvalid;
        - (void)styleDisable;
        - (void)styleEnable;

    @end


// TIME

    /* FORM */

    @interface TimeFormGeneralPrimary : UITextField<UITextFieldDelegate>

        @property (nonatomic, copy, readwrite) UserInterface* objectUserInterface;

        - (void)setupStyle;
        - (void)styleValid;
        - (void)styleInvalid;
        - (void)styleDisable;
        - (void)styleEnable;

    @end

    @interface TimeFormGeneralSecondary : UITextField<UITextFieldDelegate>

        @property (nonatomic, copy, readwrite) UserInterface* objectUserInterface;

        - (void)setupStyle;
        - (void)styleValid;
        - (void)styleInvalid;
        - (void)styleDisable;
        - (void)styleEnable;

    @end

    /* PHOTO */

    @interface TimePhotoGeneralPrimary : UITextField<UITextFieldDelegate>

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
