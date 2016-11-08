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


// BACKGROUND

@interface ImageViewBackground : UIImageView

    - (void)setupStyle;

@end


// LOGO

@interface ImageViewLogoHat : UIImageView

    - (void)setupStyle;

@end

@interface ImageViewLogoHorizontal : UIImageView

    - (void)setupStyle;

@end


// ARC

    /* FULL SCREEN */

    @interface ImageViewArcFullScreenPrimary : UIImageView

        - (void)setupStyle;

    @end

    @interface ImageViewArcFullScreenSecondary : UIImageView

        - (void)setupStyle;

    @end

    /* HEADER */

    @interface ImageViewArcHeaderPrimary : UIImageView

        - (void)setupStyle;

    @end

    @interface ImageViewArcHeaderSecondary : UIImageView

        - (void)setupStyle;

    @end

    /* HOME */

    @interface ImageViewArcHomePrimary : UIImageView

        - (void)setupStyle;

    @end

    @interface ImageViewArcHomeSecondary : UIImageView

        - (void)setupStyle;

    @end


// GUIDE

@interface ImageViewGuideHeaderStep : UIImageView

    - (void)setupStyle;
    - (void)styleOnProgress;
    - (void)styleComplete;
    - (void)styleDisable;

@end
