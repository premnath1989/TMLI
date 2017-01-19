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


// NAVIGATION

@interface ViewSliderController : UIView

    - (void)setupStyle;

@end

@interface ViewProfile : UIView

    - (void)setupStyle;

@end

@interface StackViewNavigationDetail : UIStackView

    - (void)setupStyle;

@end

@interface ViewNavigation : UIView

    - (void)setupStyle;

@end

@interface ScrollViewNavigation : UIScrollView

    - (void)setupStyle;

@end


// DESCRIPTOR

@interface ViewDescriptor : UIView

    - (void)setupStyle;

@end


// LINE

@interface ViewLineHorizontal : UIView

    - (void)setupStyle;

@end

@interface ViewLineVertical : UIView

    - (void)setupStyle;

@end


// PHOTO

@interface StackViewPhotoMenu : UIStackView

    - (void)setupStyle;

@end

@interface StackViewPhotoTitle : UIStackView

    - (void)setupStyle;

@end

@interface StackViewPhotoButton : UIStackView

    - (void)setupStyle;

@end


// GUIDE

    /* GUIDE HEADER */

    @interface StackViewGuideHeaderContent : UIStackView

        - (void)setupStyle;

    @end

    @interface ViewGuideHeader : UIView

        @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

        - (void)setupStyle;
        - (void)styleOnProgress;
        - (void)styleComplete;
        - (void)styleDisable;

    @end

    /* GUIDE DETAIL */

    @interface StackViewGuideDetailContent : UIStackView

        - (void)setupStyle;

    @end

    @interface ViewGuideDetail : UIView

        - (void)setupStyle;

    @end


// SCROLL VIEW

@interface ScrollViewSenary : UIScrollView

    - (void)setupStyle;

@end


// FORM

@interface StackViewFormVerticalContainer : UIStackView

    - (void)setupStyle;

@end

@interface StackViewFormHorizontalQuestion : UIStackView

    - (void)setupStyle;

@end

@interface StackViewFormHorizontalMultiQuestion : UIStackView

- (void)setupStyle;

@end

@interface StackViewFormVerticalQuestion : UIStackView

    - (void)setupStyle;

@end

@interface StackViewFormSlimVerticalContainer : UIStackView

    - (void)setupStyle;

@end

@interface StackViewFormSlimVerticalData : UIStackView

    - (void)setupStyle;

@end


// MAIN

@interface ViewMain : UIView

    - (void)setupStyle;

@end


// MODULE

@interface StackViewModuleDetail : UIStackView

    - (void)setupStyle;

@end

@interface ViewModule : UIView

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

    - (void)setupStyle;
    - (void)styleOnProgress;
    - (void)styleComplete;
    - (void)styleDisable;

@end


// LIST

@interface ViewTableHeader : UIView

- (void)setupStyle;

@end

@interface StackViewTableHeader : UIStackView

- (void)setupStyle;

@end

@interface StackViewTableColumn : UIStackView

- (void)setupStyle;

@end
