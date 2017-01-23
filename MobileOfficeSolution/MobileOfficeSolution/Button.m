//
//  TextFieldPrimary.m
//  Practice
//
//  Created by Ibrahim on 20/05/2016.
//  Copyright © 2016 Ibrahim. All rights reserved.
//


// IMPORT

#import "Button.h"
#import "Theme.h"
#import "Font Size.h"
#import "Dimension.h"


// FORM

@implementation ButtonFormPrimary

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0];
        [self.heightAnchor constraintEqualToConstant:GENERAL_HEIGHT_SINGLE].active = true;
        [self.widthAnchor constraintGreaterThanOrEqualToConstant:GENERAL_WIDTH_MEDIUM].active = true;
        [self setTitleColor:[objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_BUTTON_FORM]];
        self.layer.cornerRadius = BUTTON_RADIUS_BORDER;
        [self.titleLabel setTextAlignment : NSTextAlignmentCenter];
    }

@end

@implementation ButtonFormSecondary

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SECONDARY floatOpacity:1.0];
        [self.heightAnchor constraintEqualToConstant:GENERAL_HEIGHT_SINGLE].active = true;
        [self.widthAnchor constraintGreaterThanOrEqualToConstant:GENERAL_WIDTH_MEDIUM].active = true;
        [self setTitleColor:[objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_BUTTON_FORM]];
        self.layer.cornerRadius = BUTTON_RADIUS_BORDER;
        [self.titleLabel setTextAlignment : NSTextAlignmentCenter];
    }

@end


// NAVIGATION

@implementation ButtonProfile

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:0.0];
        [self setTitle:@"" forState:UIControlStateNormal];
        [self.widthAnchor constraintEqualToConstant:ICON_SIZE_MEDIUM].active = true;
        [self.heightAnchor constraintEqualToConstant:ICON_SIZE_MEDIUM].active = true;
    }

@end

@implementation ButtonNavigation

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:0.0];
        [self setTitle:@"" forState:UIControlStateNormal];
        [self.widthAnchor constraintEqualToConstant:ICON_SIZE_MEDIUM].active = true;
        [self.heightAnchor constraintEqualToConstant:ICON_SIZE_MEDIUM].active = true;
        [self setBackgroundImage:[UIImage imageNamed:@"icon_navigationshow_primary"] forState:UIControlStateNormal];
    }

    - (void)styleSelected
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
        //    self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0];
        [self setBackgroundImage:[UIImage imageNamed:@"icon_navigationhide_primary"] forState:UIControlStateNormal];
    }

    - (void)styleNotSelected
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
        //    self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0];
        [self setBackgroundImage:[UIImage imageNamed:@"icon_navigationshow_secondary"] forState:UIControlStateNormal];
    }

@end

@implementation ButtonNavigation2

/* INITIALIZE */

- (void)awakeFromNib{[self setupStyle];}


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:0.0];
    [self setTitle:@"" forState:UIControlStateNormal];
    [self.widthAnchor constraintEqualToConstant:ICON_SIZE_MEDIUM].active = true;
    [self.heightAnchor constraintEqualToConstant:ICON_SIZE_MEDIUM].active = true;
    [self setBackgroundImage:[UIImage imageNamed:@"icon_navigationshow_secondary"] forState:UIControlStateNormal];
}

- (void)styleSelected
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
//    self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0];
    [self setBackgroundImage:[UIImage imageNamed:@"icon_navigationhide_primary"] forState:UIControlStateNormal];
}

- (void)styleNotSelected
{
   UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
//    self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0];
    [self setBackgroundImage:[UIImage imageNamed:@"icon_navigationshow_secondary"] forState:UIControlStateNormal];
}

@end

@implementation ButtonCancelNavigationPrimary

/* INITIALIZE */

- (void)awakeFromNib{[self setupStyle];}


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:0.0];
    [self setTitle:@"" forState:UIControlStateNormal];
    [self.widthAnchor constraintEqualToConstant:ICON_SIZE_MEDIUM].active = true;
    [self.heightAnchor constraintEqualToConstant:ICON_SIZE_MEDIUM].active = true;
    [self setBackgroundImage:[UIImage imageNamed:@"icon_navigationhide_primary"] forState:UIControlStateNormal];
}


@end

@implementation ButtonCancelNavigationSecondary

/* INITIALIZE */

- (void)awakeFromNib{[self setupStyle];}


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:0.0];
    [self setTitle:@"" forState:UIControlStateNormal];
    [self.widthAnchor constraintEqualToConstant:ICON_SIZE_MEDIUM].active = true;
    [self.heightAnchor constraintEqualToConstant:ICON_SIZE_MEDIUM].active = true;
    [self setBackgroundImage:[UIImage imageNamed:@"icon_navigationhide_secondary"] forState:UIControlStateNormal];
}


@end

@implementation ButtonBack

/* INITIALIZE */

- (void)awakeFromNib{[self setupStyle];}


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:0.0];
    [self setTitle:@"" forState:UIControlStateNormal];
    [self.widthAnchor constraintEqualToConstant:ICON_SIZE_MEDIUM].active = true;
    [self.heightAnchor constraintEqualToConstant:ICON_SIZE_MEDIUM].active = true;
    [self setBackgroundImage:[UIImage imageNamed:@"icon_back_secondary"] forState:UIControlStateNormal];
}

@end

@implementation ButtonBackPrimary


/* INITIALIZE */

- (void)awakeFromNib{[self setupStyle];}


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:0.0];
    [self setTitle:@"" forState:UIControlStateNormal];
    [self.widthAnchor constraintEqualToConstant:ICON_SIZE_SMALL].active = true;
    [self.heightAnchor constraintEqualToConstant:ICON_SIZE_SMALL].active = true;
    [self setBackgroundImage:[UIImage imageNamed:@"icon_back_primary"] forState:UIControlStateNormal];
}

@end


@implementation ButtonHeader

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_OCTONARY floatOpacity:1.0];
        [self setTitle:@"" forState:UIControlStateNormal];
        [self.heightAnchor constraintEqualToConstant:NAVIGATION_HEIGHT_GRIP].active = true;
        [self setImage:[UIImage imageNamed:@"icon_grip_primary"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.tintColor = [objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
        self.imageEdgeInsets = UIEdgeInsetsMake(NAVIGATION_HEIGHT_GRIP / 3, 0, NAVIGATION_HEIGHT_GRIP / 3, 0);
    }

@end

/* HORIZONTAL */

@implementation ButtonNavigationHorizontalHeader

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_OCTONARY floatOpacity:1.0];
        [self.widthAnchor constraintEqualToConstant:NAVIGATION_WIDTH_HEADER].active = true;
        [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_NAVIGATION_HEADER]];
        [self setTitleColor:[objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0] forState:UIControlStateNormal];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self.titleLabel setFrame:CGRectMake(0, 0, NAVIGATION_WIDTH_HEADER - (GENERAL_SPACE_LITTLE * 2), 45)];
        [self.titleLabel setNumberOfLines : 2];
        [self.titleLabel setLineBreakMode : NSLineBreakByWordWrapping];
        [self.titleLabel setTextAlignment : NSTextAlignmentCenter];
        // CGSize sizeTitle = [self.titleLabel.text sizeWithAttributes: @{NSFontAttributeName:self.titleLabel.font}];
        CGSize sizeTitle = self.titleLabel.frame.size;
        self.titleEdgeInsets = UIEdgeInsetsMake(GENERAL_SPACE_ENORMOUS, - GENERAL_SPACE_LITTLE - ICON_SIZE_MEDIUM + (NAVIGATION_WIDTH_HEADER / 2) - (sizeTitle.width / 2) , 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(-GENERAL_SPACE_HUGE, ((NAVIGATION_WIDTH_HEADER - ICON_SIZE_MEDIUM) / 2)  - GENERAL_SPACE_LITTLE, 0, 0);
        self.contentEdgeInsets = UIEdgeInsetsMake(GENERAL_SPACE_LITTLE, GENERAL_SPACE_LITTLE, GENERAL_SPACE_LITTLE, GENERAL_SPACE_LITTLE);
        self.layer.borderColor = [objectUserInterface generateUIColor:THEME_COLOR_NONARY floatOpacity:1.0].CGColor;
        self.layer.borderWidth = GENERAL_WIDTH_THIN;
    }

@end

@implementation ButtonNavigationHorizontalDetail

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_NONARY floatOpacity:1.0];
        [self.widthAnchor constraintEqualToConstant:NAVIGATION_WIDTH_DETAIL].active = true;
        [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_NAVIGATION_DETAIL]];
        [self setTitleColor:[objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0] forState:UIControlStateNormal];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self.titleLabel setFrame : CGRectMake(0, 0, NAVIGATION_WIDTH_DETAIL - (GENERAL_SPACE_LITTLE * 2), 45)];
        [self.titleLabel setNumberOfLines : 2];
        [self.titleLabel setLineBreakMode : NSLineBreakByWordWrapping];
        [self.titleLabel setTextAlignment : NSTextAlignmentCenter];
        // CGSize sizeTitle = [self.titleLabel.text sizeWithAttributes: @{NSFontAttributeName:self.titleLabel.font}];
        CGSize sizeTitle = self.titleLabel.frame.size;
        self.titleEdgeInsets = UIEdgeInsetsMake(GENERAL_SPACE_ENORMOUS, - GENERAL_SPACE_LITTLE - ICON_SIZE_MEDIUM + (NAVIGATION_WIDTH_DETAIL / 2) - (sizeTitle.width / 2), 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake
        (
         -GENERAL_SPACE_HUGE + (ICON_SIZE_MEDIUM - ICON_SIZE_SMALL) / 2,
         (NAVIGATION_WIDTH_DETAIL - GENERAL_SPACE_MEDIUM - ICON_SIZE_MEDIUM) / 2 + (ICON_SIZE_MEDIUM - ICON_SIZE_SMALL) / 2,
         0,
         44
         );
        self.contentEdgeInsets = UIEdgeInsetsMake(GENERAL_SPACE_LITTLE, GENERAL_SPACE_LITTLE, GENERAL_SPACE_LITTLE, GENERAL_SPACE_LITTLE);
        self.layer.borderColor = [objectUserInterface generateUIColor:THEME_COLOR_DARK floatOpacity:1.0].CGColor;
        self.layer.borderWidth = GENERAL_WIDTH_THIN;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }

@end

/* VERTICAL */

@implementation ButtonNavigationVerticalHeader

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_OCTONARY floatOpacity:1.0];
        [self.heightAnchor constraintEqualToConstant:NAVIGATION_HEIGHT_HEADER].active = true;
        [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_NAVIGATION_HEADER]];
        [self setTitleColor:[objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0] forState:UIControlStateNormal];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        self.layer.borderColor = [objectUserInterface generateUIColor:THEME_COLOR_NONARY floatOpacity:1.0].CGColor;
        self.layer.borderWidth = GENERAL_WIDTH_THIN;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, GENERAL_SPACE_MEDIUM, 0, 0);
        self.contentEdgeInsets = UIEdgeInsetsMake(0, GENERAL_SPACE_MEDIUM, 0, GENERAL_SPACE_MEDIUM);
    }

@end

@implementation ButtonNavigationVerticalDetail

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_NONARY floatOpacity:1.0];
        [self.heightAnchor constraintEqualToConstant:NAVIGATION_HEIGHT_DETAIL].active = true;
        [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_NAVIGATION_DETAIL]];
        [self setTitleColor:[objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0] forState:UIControlStateNormal];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        self.layer.borderColor = [objectUserInterface generateUIColor:THEME_COLOR_NONARY floatOpacity:1.0].CGColor;
        self.layer.borderWidth = GENERAL_WIDTH_THIN;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, GENERAL_SPACE_MEDIUM, 0, 0);
        self.contentEdgeInsets = UIEdgeInsetsMake(GENERAL_SPACE_LITTLE, GENERAL_SPACE_MEDIUM, GENERAL_SPACE_LITTLE, GENERAL_SPACE_MEDIUM);
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }

@end


// PHOTO

@implementation ButtonPhotoUnderline

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:0.0];
        [self.heightAnchor constraintEqualToConstant:GENERAL_HEIGHT_SINGLE].active = true;
        [self setTitleColor:[objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_SECONDARY size:FONTSIZE_BUTTON_PHOTO]];
    }

@end

@implementation ButtonPhotoTitleRight

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0];
        [self.heightAnchor constraintEqualToConstant:GENERAL_HEIGHT_SINGLE].active = true;
        [self setTitleColor:[objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_BUTTON_FORM]];
        UIImage *imageBackground = [UIImage imageNamed:@"shape_guideright_complete"];
        [self setImage:imageBackground forState:UIControlStateNormal];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -imageBackground.size.width / 4, 0, 0);
        self.layer.cornerRadius = BUTTON_RADIUS_BORDER;
        self.layer.masksToBounds = true;
        self.tintColor = [objectUserInterface generateUIColor:THEME_COLOR_SECONDARY floatOpacity:1.0];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageBackground.size.width / 4, 0, 0);
    }

@end

@implementation ButtonPhotoTitleLeft

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0];
        [self.heightAnchor constraintEqualToConstant:GENERAL_HEIGHT_SINGLE].active = true;
        [self setTitleColor:[objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_BUTTON_FORM]];
        UIImage *imageBackground = [UIImage imageNamed:@"shape_guideleft_complete"];
        [self setImage:imageBackground forState:UIControlStateNormal];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -self.bounds.size.width + (imageBackground.size.width / 6));
        self.layer.cornerRadius = BUTTON_RADIUS_BORDER;
        self.layer.masksToBounds = true;
        self.tintColor = [objectUserInterface generateUIColor:THEME_COLOR_SECONDARY floatOpacity:1.0];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.bounds.size.width, 0, imageBackground.size.width / 2 + GENERAL_SPACE_SMALL);
    }

@end

@implementation ButtonPhotoTitleLeftProspect

/* INITIALIZE */

- (void)awakeFromNib{[self setupStyle];}


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0];
    [self.heightAnchor constraintEqualToConstant:GENERAL_HEIGHT_SINGLE].active = true;
    [self setTitleColor:[objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_BUTTON_FORM]];
    UIImage *imageBackground = [UIImage imageNamed:@"shape_guideleft_complete"];
    [self setImage:imageBackground forState:UIControlStateNormal];
    [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -self.bounds.size.width + (imageBackground.size.width+10));
    self.layer.cornerRadius = BUTTON_RADIUS_BORDER;
    self.layer.masksToBounds = true;
    self.tintColor = [objectUserInterface generateUIColor:THEME_COLOR_SECONDARY floatOpacity:1.0];
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.bounds.size.width, 0, imageBackground.size.width / 2 + GENERAL_SPACE_SMALL);
}

@end

// SLIDER

@implementation ButtonSlider

    /* INITIALIZE */

    - (void)awakeFromNib
    {
        [self setupStyle];
    }


    /* FUNCTION */

    - (void)setupStyle
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0];
        [self.heightAnchor constraintEqualToConstant:BUTTON_SIZE_SLIDER].active = true;
        [self.widthAnchor constraintEqualToConstant:BUTTON_SIZE_SLIDER].active = true;
        [self setTitle:@"" forState:UIControlStateNormal];
        self.layer.cornerRadius = BUTTON_SIZE_SLIDER / 2;
    }

    - (void)styleSelected
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0];
    }

    - (void)styleNotSelected
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0];
    }

@end


// MASKING

@implementation ButtonMasking

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:0];
        [self setTitle:@"" forState:UIControlStateNormal];
    }

@end


// GUIDE

@implementation ButtonGuideDetail

    /* INITIALIZE */

    - (void)awakeFromNib{[self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0];
        [self.heightAnchor constraintEqualToConstant:GUIDEDETAIL_SIZE_BUTTON].active = true;
        [self.widthAnchor constraintEqualToConstant:GUIDEDETAIL_SIZE_BUTTON].active = true;
        self.layer.cornerRadius = GUIDEDETAIL_SIZE_BUTTON / 2;
        [self setTitleColor:[_objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_GUIDEDETAIL_STEP]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }

    - (void)styleOnProgress
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0];
        [self setTitleColor:[_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0] forState:UIControlStateNormal];
    }

    - (void)styleComplete
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0];
        [self setTitleColor:[_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0] forState:UIControlStateNormal];
    }

    - (void)styleDisable
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0];
        [self setTitleColor:[_objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0] forState:UIControlStateNormal];
    }

@end


// INFORMATION

@implementation ButtonFavouriteStar

    /* INITIALIZE */

    - (void)awakeFromNib{ [super awakeFromNib]; [self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        [self.heightAnchor constraintEqualToConstant:ICON_SIZE_TINY].active = true;
        [self.widthAnchor constraintEqualToConstant:ICON_SIZE_TINY].active = true;
        
        [self setImage:[UIImage imageNamed:@"icon_star1_secondary"] forState:UIControlStateNormal];
        [self setContentMode:UIViewContentModeScaleAspectFill];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTitle:@"" forState:UIControlStateNormal];
    }

    - (void)styleSelected
    {
        [self setImage:[UIImage imageNamed:@"icon_star1_primary"] forState:UIControlStateNormal];
    }

    - (void)styleNotSelected
    {
        [self setImage:[UIImage imageNamed:@"icon_star1_secondary"] forState:UIControlStateNormal];
    }

@end


// ALERT

@implementation ButtonAlertPositive

    /* INITIALIZE */

    - (void)awakeFromNib{ [super awakeFromNib]; [self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self.heightAnchor constraintEqualToConstant:BUTTON_HEIGHT_ALERT].active = true;
        [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_SECONDARY size:FONTSIZE_BUTTON_ALERT]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor clearColor]];
    }

@end

@implementation ButtonAlertNegative

    /* INITIALIZE */

    - (void)awakeFromNib{ [super awakeFromNib]; [self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        [self.heightAnchor constraintEqualToConstant:BUTTON_HEIGHT_ALERT].active = true;
        [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_SECONDARY size:FONTSIZE_BUTTON_ALERT]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor clearColor]];
    }

@end

@implementation ButtonAlertNeutral

    /* INITIALIZE */

    - (void)awakeFromNib{ [super awakeFromNib]; [self setupStyle];}


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self.heightAnchor constraintEqualToConstant:BUTTON_HEIGHT_ALERT].active = true;
        [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_BUTTON_ALERT]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor clearColor]];
    }

@end


// TABLE

@implementation ButtonTableHeader

/* INITIALIZE */

- (void)awakeFromNib{[self setupStyle];}


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:0.0];
    [self.titleLabel setFont:[UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_LISTHEADER_HEADER]];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0] forState:UIControlStateNormal];
}

@end

@implementation ButtonFormCircleSmall

    /* INITIALIZE */

    - (void)awakeFromNib
    {
        [self setupStyle];
    }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:0.0];
        [self.heightAnchor constraintEqualToConstant:BUTTON_SIZE_SMALL].active = true;
        [self.widthAnchor constraintEqualToConstant:BUTTON_SIZE_SMALL].active = true;
        [self setTitle:@"" forState:UIControlStateNormal];
        self.layer.cornerRadius = BUTTON_SIZE_SLIDER / 2;
    }

@end

@implementation ButtonFormCircleMedium

    /* INITIALIZE */

    - (void)awakeFromNib
    {
        [self setupStyle];
    }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:0.0];
        [self.heightAnchor constraintEqualToConstant:BUTTON_SIZE_MEDIUM].active = true;
        [self.widthAnchor constraintEqualToConstant:BUTTON_SIZE_MEDIUM].active = true;
        [self setTitle:@"" forState:UIControlStateNormal];
        self.layer.cornerRadius = BUTTON_SIZE_SLIDER / 2;
    }

@end
