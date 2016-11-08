//
//  TextFieldPrimary.m
//  Practice
//
//  Created by Ibrahim on 20/05/2016.
//  Copyright © 2016 Ibrahim. All rights reserved.
//


// IMPORT

#import "Image.h"
#import "Theme.h"
#import "User Interface.h"
#import "Dimension.h"


// BACKGROUND

@implementation ImageViewBackground

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setContentMode:UIViewContentModeScaleAspectFill];
        self.clipsToBounds = true;
        self.layer.masksToBounds = true;
    }

@end


// LOGO

@implementation ImageViewLogoHat

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self.heightAnchor constraintEqualToConstant:LOGO_HEIGHT_HAT].active = true;
        [self.widthAnchor constraintEqualToConstant:LOGO_WIDTH_HAT].active = true;
        [self setImage:[UIImage imageNamed:@"logo_tmlihat_primary"]];
        [self setContentMode:UIViewContentModeScaleAspectFill];
    }

@end

@implementation ImageViewLogoHorizontal

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self.heightAnchor constraintEqualToConstant:LOGO_HEIGHT_HORIZONTAL].active = true;
        [self.widthAnchor constraintEqualToConstant:LOGO_WIDTH_HORIZONTAL].active = true;
        [self setImage:[UIImage imageNamed:@"logo_tmlihorizontal_primary"]];
        [self setContentMode:UIViewContentModeScaleAspectFill];
    }

@end


// ARC

    /* FULL SCREEN */

    @implementation ImageViewArcFullScreenPrimary

        /* INITIALIZE */

        - (void)awakeFromNib { [self setupStyle]; }


        /* FUNCTION */

        - (void)setupStyle
        {
            UserInterface *objectUserInterface = [[UserInterface alloc] init];
            
            [self.heightAnchor constraintEqualToConstant:ARC_SIZE_FULLSCREEN].active = true;
            [self.widthAnchor constraintEqualToConstant:ARC_SIZE_FULLSCREEN].active = true;
            [self setImage:[UIImage imageNamed:@"shape_arcfullscreen_primary"]];
            [self setContentMode:UIViewContentModeScaleAspectFill];
        }

    @end

    @implementation ImageViewArcFullScreenSecondary

        /* INITIALIZE */

        - (void)awakeFromNib { [self setupStyle]; }


        /* FUNCTION */

        - (void)setupStyle
        {
            UserInterface *objectUserInterface = [[UserInterface alloc] init];
            
            [self.heightAnchor constraintEqualToConstant:ARC_SIZE_FULLSCREEN].active = true;
            [self.widthAnchor constraintEqualToConstant:ARC_SIZE_FULLSCREEN].active = true;
            [self setImage:[UIImage imageNamed:@"shape_arcfullscreen_secondary"]];
            [self setContentMode:UIViewContentModeScaleAspectFill];
        }

    @end

    /* HEADER */

    @implementation ImageViewArcHeaderPrimary

        /* INITIALIZE */

        - (void)awakeFromNib { [self setupStyle]; }


        /* FUNCTION */

        - (void)setupStyle
        {
            UserInterface *objectUserInterface = [[UserInterface alloc] init];
            
            [self.heightAnchor constraintEqualToConstant:ARC_SIZE_HEADER].active = true;
            [self.widthAnchor constraintEqualToConstant:ARC_SIZE_HEADER].active = true;
            [self setImage:[UIImage imageNamed:@"shape_archeader_primary"]];
            [self setContentMode:UIViewContentModeScaleAspectFill];
        }

    @end

    @implementation ImageViewArcHeaderSecondary

        /* INITIALIZE */

        - (void)awakeFromNib { [self setupStyle]; }


        /* FUNCTION */

        - (void)setupStyle
        {
            UserInterface *objectUserInterface = [[UserInterface alloc] init];
            
            [self.heightAnchor constraintEqualToConstant:ARC_SIZE_HEADER].active = true;
            [self.widthAnchor constraintEqualToConstant:ARC_SIZE_HEADER].active = true;
            [self setImage:[UIImage imageNamed:@"shape_archeader_secondary"]];
            [self setContentMode:UIViewContentModeScaleAspectFill];
        }

    @end

    /* HOME */

    @implementation ImageViewArcHomePrimary

        /* INITIALIZE */

        - (void)awakeFromNib { [self setupStyle]; }


        /* FUNCTION */

        - (void)setupStyle
        {
            UserInterface *objectUserInterface = [[UserInterface alloc] init];
            
            [self.heightAnchor constraintEqualToConstant:ARC_SIZE_HOME].active = true;
            [self.widthAnchor constraintEqualToConstant:ARC_SIZE_HOME].active = true;
            [self setImage:[UIImage imageNamed:@"shape_archome_primary"]];
            [self setContentMode:UIViewContentModeScaleAspectFill];
        }

    @end

    @implementation ImageViewArcHomeSecondary

        /* INITIALIZE */

        - (void)awakeFromNib { [self setupStyle]; }


        /* FUNCTION */

        - (void)setupStyle
        {
            UserInterface *objectUserInterface = [[UserInterface alloc] init];
            
            [self.heightAnchor constraintEqualToConstant:ARC_SIZE_HOME].active = true;
            [self.widthAnchor constraintEqualToConstant:ARC_SIZE_HOME].active = true;
            [self setImage:[UIImage imageNamed:@"shape_archome_secondary"]];
            [self setContentMode:UIViewContentModeScaleAspectFill];
        }

    @end


// GUIDE

@implementation ImageViewGuideHeaderStep

    /* INITIALIZE */

    - (void)awakeFromNib
    {
        [self setupStyle];
    }


    /* FUNCTION */

    - (void)setupStyle
    {
        [self.heightAnchor constraintEqualToConstant:ICON_SIZE_LARGE].active = true;
        [self.widthAnchor constraintEqualToConstant:ICON_SIZE_LARGE].active = true;
        [self setImage:[UIImage imageNamed:@"shape_guideright_disable"]];
        [self setContentMode:UIViewContentModeScaleAspectFill];
    }

    - (void)styleOnProgress
    {
        [self setImage:[UIImage imageNamed:@"shape_guideright_onprogress"]];
    }

    - (void)styleComplete
    {
        [self setImage:[UIImage imageNamed:@"shape_guideright_complete"]];
    }

    - (void)styleDisable
    {
        [self setImage:[UIImage imageNamed:@"shape_guideright_disable"]];
    }

@end
