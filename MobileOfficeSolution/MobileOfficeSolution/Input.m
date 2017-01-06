//
//  TextFieldPrimary.m
//  Practice
//
//  Created by Ibrahim on 20/05/2016.
//  Copyright © 2016 Ibrahim. All rights reserved.
//


// IMPORT

#import "Input.h"
#import "Theme.h"
#import "Dimension.h"
#import "Font Size.h"


// TEXTFIELD

    /* FORM */

    @implementation TextFieldFormGeneralPrimary

        /* INITIALIZE */

        - (void)awakeFromNib { [self setupStyle]; }

        - (CGRect)textRectForBounds:(CGRect)bounds
        {
            return CGRectMake
            (
             bounds.origin.x + GENERAL_SPACE_SMALL, bounds.origin.y + GENERAL_SPACE_TINY,
             bounds.size.width + (GENERAL_SPACE_SMALL * 2), bounds.size.height - (GENERAL_SPACE_TINY * 2)
             );
        }

        - (CGRect)editingRectForBounds:(CGRect)bounds { return [self textRectForBounds:bounds]; }


        /* FUNCTION */

        - (void)setupStyle
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self.heightAnchor constraintEqualToConstant:GENERAL_HEIGHT_SINGLE].active = true;
            
            [self setContentVerticalAlignment : UIControlContentVerticalAlignmentCenter];
            [self setTextAlignment : NSTextAlignmentLeft];
            self.textColor = [_objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0];
            [self setFont:[UIFont fontWithName:THEME_FONT_PRIMARY size:FONTSIZE_TEXTFIELD_FORM]];
            self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
            self.borderStyle = UITextBorderStyleLine;
            self.layer.borderWidth = INPUT_WIDTH_BORDER;
            self.layer.cornerRadius = INPUT_RADIUS_BORDER;
            self.layer.masksToBounds = YES;
            self.layer.borderColor = [_objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0].CGColor;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
        }

    @end

    @implementation TextFieldFormGeneralSecondary

        /* INITIALIZE */

        - (void)awakeFromNib { [self setupStyle]; }

        - (CGRect)textRectForBounds:(CGRect)bounds
        {
            return CGRectMake
            (
             bounds.origin.x + GENERAL_SPACE_SMALL, bounds.origin.y + GENERAL_SPACE_TINY,
             bounds.size.width + (GENERAL_SPACE_SMALL * 2), bounds.size.height - (GENERAL_SPACE_TINY * 2)
             );
        }

        - (CGRect)editingRectForBounds:(CGRect)bounds { return [self textRectForBounds:bounds]; }


        /* FUNCTION */

        - (void)setupStyle
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self.heightAnchor constraintEqualToConstant:GENERAL_HEIGHT_SINGLE].active = true;
            
            [self setContentVerticalAlignment : UIControlContentVerticalAlignmentCenter];
            [self setTextAlignment : NSTextAlignmentLeft];
            self.textColor = [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0];
            [self setFont:[UIFont fontWithName:THEME_FONT_PRIMARY size:FONTSIZE_TEXTFIELD_FORM]];
            self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_OCTONARY floatOpacity:0.2];
            self.borderStyle = UITextBorderStyleNone;
            self.layer.cornerRadius = INPUT_RADIUS_BORDER;
            self.layer.masksToBounds = YES;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
        }

    @end

    /* FORM */

    @implementation TextFieldPhotoGeneralPrimary

        /* INITIALIZE */

        - (void)awakeFromNib { [self setupStyle]; }

        - (CGRect)textRectForBounds:(CGRect)bounds
        {
            return CGRectMake
            (
             bounds.origin.x + GENERAL_SPACE_SMALL, bounds.origin.y + GENERAL_SPACE_TINY,
             bounds.size.width + (GENERAL_SPACE_SMALL * 2), bounds.size.height - (GENERAL_SPACE_TINY * 2)
             );
        }

        - (CGRect)editingRectForBounds:(CGRect)bounds { return [self textRectForBounds:bounds]; }


        /* FUNCTION */

        - (void)setupStyle
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self.heightAnchor constraintEqualToConstant:GENERAL_HEIGHT_SINGLE].active = true;
            
            [self setContentVerticalAlignment : UIControlContentVerticalAlignmentCenter];
            [self setTextAlignment : NSTextAlignmentLeft];
            self.textColor = [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0];
            [self setFont:[UIFont fontWithName:THEME_FONT_PRIMARY size:FONTSIZE_TEXTFIELD_FORM]];
            self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_OCTONARY floatOpacity:INPUT_OPACITY_BACKGROUND];
            self.borderStyle = UITextBorderStyleNone;
            self.layer.cornerRadius = INPUT_RADIUS_BORDER;
            self.layer.masksToBounds = YES;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            // [self setValue:[_objectUserInterface generateUIColor:THEME_COLOR_ERROR floatOpacity:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        }

    @end


// PROGRESS VIEW

@implementation ProgressViewGuideHeader

    /* INITIALIZE */

    - (void)awakeFromNib
    {
        [self setupStyle];
        [self styleOnProgress];
        [self styleComplete];
        [self styleDisable];
    }

    /* FUNCTION */

    - (void)setupStyle
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self.heightAnchor constraintEqualToConstant:PROGRESSVIEW_HEIGHT_BAR].active = true;
        self.progress = 0.5;
        self.progressTintColor = [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0];
        self.trackTintColor = [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0];
        self.layer.cornerRadius = GENERAL_RADIUS_FORM;
    }

    - (void)styleOnProgress
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.progressTintColor = [_objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0];
        self.trackTintColor = [_objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0];
    }

    - (void)styleComplete
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.progressTintColor = [_objectUserInterface generateUIColor:THEME_COLOR_SECONDARY floatOpacity:1.0];
        self.trackTintColor = [_objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0];
    }

    - (void)styleDisable
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.progressTintColor = [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0];
        self.trackTintColor = [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0];
    }

@end


// SECGMENTED CONTROL

@implementation SegmentedControlFormGeneralPrimary

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self.heightAnchor constraintEqualToConstant:GENERAL_HEIGHT_SINGLE].active = true;
        
        [self setContentVerticalAlignment : UIControlContentVerticalAlignmentCenter];
        [self setContentHorizontalAlignment : UIControlContentHorizontalAlignmentCenter];
        self.tintColor = [_objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0];
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
        self.layer.cornerRadius = INPUT_RADIUS_BORDER;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = INPUT_WIDTH_BORDER;
        self.layer.borderColor = [_objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0].CGColor;
        UIFont *fontSetup = [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_TEXTFIELD_FORM];
        NSDictionary *dictionaryFontSetup = [NSDictionary dictionaryWithObject:fontSetup forKey:NSFontAttributeName];
        [self setTitleTextAttributes:dictionaryFontSetup forState:UIControlStateNormal];
        
        
        // [menu setSelectedSegmentIndex:UISegmentedControlNoSegment];
    }



@end
