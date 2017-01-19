//
//  TextFieldPrimary.m
//  Practice
//
//  Created by Ibrahim on 20/05/2016.
//  Copyright © 2016 Ibrahim. All rights reserved.
//


// IMPORT

#import "Layout.h"
#import "Theme.h"
#import "Dimension.h"


// SLIDER

@implementation ViewSliderController

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self.heightAnchor constraintEqualToConstant:GENERAL_HEIGHT_SINGLE].active = true;
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
    }

@end


// NAVIGATION

@implementation ViewProfile

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self.heightAnchor constraintEqualToConstant:PROFILE_HEIGHT_VIEW].active = true;
        [self.widthAnchor constraintEqualToConstant:PROFILE_WIDTH_VIEW].active = true;
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_OCTONARY floatOpacity:1.0];
        self.layer.borderWidth = GENERAL_WIDTH_THIN;
        self.layer.borderColor = [objectUserInterface generateUIColor:THEME_COLOR_NONARY floatOpacity:1.0].CGColor;
    }

@end

@implementation StackViewNavigationDetail

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        self.hidden = true;
    }

@end

@implementation ViewNavigation

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_OCTONARY floatOpacity:1.0];
        self.layer.borderWidth = GENERAL_WIDTH_THIN;
        self.layer.borderColor = [objectUserInterface generateUIColor:THEME_COLOR_NONARY floatOpacity:1.0].CGColor;
    }

@end

@implementation ScrollViewNavigation

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_OCTONARY floatOpacity:1.0];
        self.layer.borderWidth = GENERAL_WIDTH_THIN;
        self.layer.borderColor = [objectUserInterface generateUIColor:THEME_COLOR_NONARY floatOpacity:1.0].CGColor;
    }

@end


// DESCRIPTOR

@implementation ViewDescriptor

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self.heightAnchor constraintEqualToConstant:DESCRIPTOR_HEIGHT_VIEW].active = true;
        [self.widthAnchor constraintEqualToConstant:DESCRIPTOR_WIDTH_VIEW].active = true;
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:0.0];
    }

@end


// LINE

@implementation ViewLineHorizontal

/* INITIALIZE */

- (void)awakeFromNib { [self setupStyle]; }


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    [self.heightAnchor constraintEqualToConstant:GENERAL_WIDTH_THIN].active = true;
    self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0];
}

@end

@implementation ViewLineVertical

/* INITIALIZE */

- (void)awakeFromNib { [self setupStyle]; }


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    [self.widthAnchor constraintEqualToConstant:GENERAL_WIDTH_THIN].active = true;
    self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0];
}

@end


// PHOTO

@implementation StackViewPhotoMenu

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        self.axis = UILayoutConstraintAxisVertical;
        self.distribution = UIStackViewDistributionFill;
        self.alignment = UIStackViewAlignmentCenter;
        self.spacing = GENERAL_SPACE_HUGE;
    }

@end

@implementation StackViewPhotoTitle

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        self.axis = UILayoutConstraintAxisVertical;
        self.distribution = UIStackViewDistributionFill;
        self.alignment = UIStackViewAlignmentCenter;
        self.spacing = GENERAL_SPACE_LITTLE;
    }

@end

@implementation StackViewPhotoButton

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        self.axis = UILayoutConstraintAxisHorizontal;
        self.spacing = GENERAL_SPACE_HUGE;
        self.distribution = UIStackViewDistributionFill;
        self.alignment = UIStackViewAlignmentCenter;
    }

@end


// GUIDE

    /* GUIDE HEADER */

    @implementation StackViewGuideHeaderContent

        /* INITIALIZE */

        - (void)awakeFromNib { [self setupStyle]; }


        /* FUNCTION */

        - (void)setupStyle
        {
            self.axis = UILayoutConstraintAxisVertical;
            self.spacing = GENERAL_SPACE_TINY;
            self.distribution = UIStackViewDistributionFill;
            self.alignment = UIStackViewAlignmentFill;
        }

    @end

    @implementation ViewGuideHeader

        /* INITIALIZE */

        - (void)awakeFromNib
        {
            [self setupStyle];
        }


        /* FUNCTION */

        - (void)setupStyle
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self.widthAnchor constraintEqualToConstant:GUIDEHEADER_WIDTH_VIEW].active = true;
            [self.heightAnchor constraintEqualToConstant:GUIDEHEADER_HEIGHT_VIEW].active = true;
            self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
        }

        - (void)styleOnProgress
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
        }

        - (void)styleComplete
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0];
        }

        - (void)styleDisable
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
        }

    @end

    /* GUIDE DETAIL */

    @implementation StackViewGuideDetailContent

        /* INITIALIZE */

        - (void)awakeFromNib { [self setupStyle]; }


        /* FUNCTION */

        - (void)setupStyle
        {
            self.axis = UILayoutConstraintAxisVertical;
            self.spacing = GENERAL_SPACE_MEDIUM;
            self.distribution = UIStackViewDistributionFill;
            self.alignment = UIStackViewAlignmentCenter;
        }

    @end

    @implementation ViewGuideDetail

        /* INITIALIZE */

        - (void)awakeFromNib { [self setupStyle]; }


        /* FUNCTION */

        - (void)setupStyle
        {
            UserInterface *objectUserInterface = [[UserInterface alloc] init];
            
            [self.widthAnchor constraintEqualToConstant:GUIDEDETAIL_WIDTH_VIEW].active = true;
            self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
        }

    @end


// SCROLL VIEW

@implementation ScrollViewSenary

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
    }

@end


// FORM

@implementation StackViewFormVerticalContainer

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        self.axis = UILayoutConstraintAxisVertical;
        self.spacing = GENERAL_SPACE_LARGE;
        self.distribution = UIStackViewDistributionFill;
        self.alignment = UIStackViewAlignmentFill;
    }

@end

@implementation StackViewFormHorizontalQuestion

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        self.axis = UILayoutConstraintAxisHorizontal;
        self.spacing = GENERAL_SPACE_LARGE;
        self.distribution = UIStackViewDistributionFill;
        self.alignment = UIStackViewAlignmentTop;
    }

@end

@implementation StackViewFormHorizontalMultiQuestion

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        self.axis = UILayoutConstraintAxisHorizontal;
        self.spacing = GENERAL_SPACE_LARGE;
        self.distribution = UIStackViewDistributionFillEqually;
        self.alignment = UIStackViewAlignmentTop;
    }

@end

@implementation StackViewFormVerticalQuestion

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        self.axis = UILayoutConstraintAxisVertical;
        self.spacing = GENERAL_SPACE_SMALL;
        self.distribution = UIStackViewDistributionFill;
        self.alignment = UIStackViewAlignmentFill;
    }

@end

@implementation StackViewFormSlimVerticalContainer

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        self.axis = UILayoutConstraintAxisVertical;
        self.spacing = GENERAL_SPACE_MEDIUM;
        self.distribution = UIStackViewDistributionFill;
        self.alignment = UIStackViewAlignmentTop;
    }

@end

@implementation StackViewFormSlimVerticalData

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        self.axis = UILayoutConstraintAxisVertical;
        self.spacing = GENERAL_SPACE_LITTLE;
        self.distribution = UIStackViewDistributionFill;
        self.alignment = UIStackViewAlignmentTop;
    }

@end


// MAIN

@implementation ViewMain

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_OCTONARY floatOpacity:1.0];
    }

@end


// MODULE

@implementation StackViewModuleDetail

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        self.hidden = true;
    }

@end

@implementation ViewModule

    /* INITIALIZE */

    - (void)awakeFromNib
    {
        [self setupStyle];
    }


    /* FUNCTION */

    - (void)setupStyle
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self.heightAnchor constraintEqualToConstant:MODULE_HEIGHT_VIEW].active = true;
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
    }

    - (void)styleOnProgress
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
    }

    - (void)styleComplete
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0];
    }

    - (void)styleDisable
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
    }

@end


// TABLE

@implementation ViewTableHeader

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0];
    }

@end

@implementation StackViewTableHeader

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        self.axis = UILayoutConstraintAxisVertical;
        self.spacing = GENERAL_SPACE_LITTLE;
        self.distribution = UIStackViewDistributionFill;
        self.alignment = UIStackViewAlignmentFill;
    }

@end

@implementation StackViewTableColumn

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        self.axis = UILayoutConstraintAxisHorizontal;
        self.spacing = 0;
        self.distribution = UIStackViewDistributionFillEqually;
        self.alignment = UIStackViewAlignmentCenter;
    }

@end
