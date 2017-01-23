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



// FORM

@interface ButtonFormPrimary : UIButton

    - (void)setupStyle;

@end

@interface ButtonFormSecondary : UIButton

    - (void)setupStyle;

@end


// NAVIGATION

@interface ButtonNavigation : UIButton

    - (void)setupStyle;
    - (void)styleSelected;
    - (void)styleNotSelected;

@end

@interface ButtonNavigation2 : UIButton

    - (void)setupStyle;
    - (void)styleSelected;
    - (void)styleNotSelected;


@end

@interface ButtonCancelNavigationPrimary : UIButton

- (void)setupStyle;

@end

@interface ButtonCancelNavigationSecondary : UIButton

- (void)setupStyle;

@end

@interface ButtonBack : UIButton

- (void)setupStyle;

@end

@interface ButtonBackPrimary : UIButton

- (void)setupStyle;

@end

@interface ButtonProfile : UIButton

    - (void)setupStyle;

@end

@interface ButtonHeader : UIButton

    - (void)setupStyle;

@end

    /* HORIZONTAL */

    @interface ButtonNavigationHorizontalHeader : UIButton

     - (void)setupStyle;

    @end

    @interface ButtonNavigationHorizontalDetail : UIButton

     - (void)setupStyle;

    @end

    /* VERTICAL */

    @interface ButtonNavigationVerticalHeader : UIButton

     - (void)setupStyle;

    @end

    @interface ButtonNavigationVerticalDetail : UIButton

     - (void)setupStyle;

    @end


// PHOTO

@interface ButtonPhotoUnderline : UIButton

    - (void)setupStyle;

@end

@interface ButtonPhotoTitleRight : UIButton

    - (void)setupStyle;

@end

@interface ButtonPhotoTitleLeft : UIButton

    - (void)setupStyle;

@end

@interface ButtonPhotoTitleLeftProspect : UIButton

- (void)setupStyle;

@end


// SLIDER

@interface ButtonSlider : UIButton

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

    - (void)setupStyle;
    - (void)styleSelected;
    - (void)styleNotSelected;

@end


// MASKING

@interface ButtonMasking : UIButton

    - (void)setupStyle;

@end


// GUIDE

@interface ButtonGuideDetail : UIButton

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

    - (void)setupStyle;
    - (void)styleOnProgress;
    - (void)styleComplete;
    - (void)styleDisable;

@end


// INFORMATION

@interface ButtonFavouriteStar : UIButton

    - (void)setupStyle;
    - (void)styleSelected;
    - (void)styleNotSelected;

@end


// ALERT

@interface ButtonAlertPositive : UIButton

    - (void)setupStyle;

@end

@interface ButtonAlertNegative : UIButton

    - (void)setupStyle;

@end

@interface ButtonAlertNeutral : UIButton

    - (void)setupStyle;

@end


// TABLE

@interface ButtonTableHeader : UIButton

    - (void)setupStyle;

@end

@interface ButtonFormCircleSmall : UIButton

    - (void)setupStyle;

@end

@interface ButtonFormCircleMedium : UIButton

    - (void)setupStyle;

@end
