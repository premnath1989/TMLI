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

@interface LabelFormSection : UILabel

    - (void)setupStyle;

@end

@interface LabelFormParagraph : UILabel

    - (void)setupStyle;

@end

@interface LabelFormNumber : UILabel

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

    - (void)setupStyle;
    - (void)styleValid;
    - (void)styleInvalid;
    - (void)styleEnable;
    - (void)styleDisable;

@end

@interface LabelFormQuestion : UILabel

    - (void)setupStyle;

@end


// PHOTO

@interface LabelPhotoSection : UILabel

    - (void)setupStyle;

@end

@interface LabelPhotoParagraph : UILabel

    - (void)setupStyle;

@end

@interface LabelPhotoHeader : UILabel

    - (void)setupStyle;

@end

@interface LabelPhotoDetail : UILabel

    - (void)setupStyle;

@end


// DESCRIPTOR

@interface LabelDescriptorHeader : UILabel

    - (void)setupStyle;

@end

@interface LabelDescriptorWebsite : UILabel

    - (void)setupStyle;

@end

@interface LabelDescriptorDetail : UILabel

    - (void)setupStyle;

@end


// TABLE

@interface LabelTableHeader : UILabel

- (void)setupStyle;

@end

@interface LabelTableDetail : UILabel

- (void)setupStyle;

@end

@interface LabelTableResult : UILabel

- (void)setupStyle;

@end

@interface LabelTableHeaderHeader : UILabel

- (void)setupStyle;

@end

@interface LabelTableHeaderDetail : UILabel

- (void)setupStyle;

@end

@interface LabelTableItemHeader : UILabel

- (void)setupStyle;

@end

@interface LabelTableItemDetail : UILabel

- (void)setupStyle;

@end


// NAVIGATION

    /* PROFILE */

    @interface LabelProfileHeader : UILabel

        - (void)setupStyle;

    @end

    @interface LabelProfileDetail : UILabel

        - (void)setupStyle;

    @end

    /* HEADER */

    @interface LabelNavigationHeader : UILabel

        - (void)setupStyle;

    @end

    /* DETAIL */

    @interface LabelNavigationDetail : UILabel

        - (void)setupStyle;

    @end


// GUIDE

    /* HEADER */

    @interface LabelGuideHeaderStep : UILabel

        @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

        - (void)setupStyle;
        - (void)styleOnProgress;
        - (void)styleComplete;
        - (void)styleDisable;

    @end

    @interface LabelGuideHeaderTitle : UILabel

        @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

        - (void)setupStyle;
        - (void)styleOnProgress;
        - (void)styleComplete;
        - (void)styleDisable;

    @end

    @interface LabelGuideHeaderState : UILabel

        @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

        - (void)setupStyle;
        - (void)styleOnProgress;
        - (void)styleComplete;
        - (void)styleDisable;

    @end

    /* DETAIL */

    @interface LabelGuideDetailStep : UILabel

        @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

        - (void)setupStyle;
        - (void)styleOnProgress;
        - (void)styleComplete;
        - (void)styleDisable;

    @end


// HEADER

@interface LabelHeaderTitle : UILabel

    - (void)setupStyle;

@end


// MODULE

@interface LabelModuleTitle : UILabel

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

    - (void)setupStyle;
    - (void)styleOnProgress;
    - (void)styleComplete;
    - (void)styleDisable;

@end

@interface LabelModuleHeader : UILabel

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

    - (void)setupStyle;
    - (void)styleOnProgress;
    - (void)styleComplete;
    - (void)styleDisable;

@end

@interface LabelModuleDetail : UILabel

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

    - (void)setupStyle;
    - (void)styleOnProgress;
    - (void)styleComplete;
    - (void)styleDisable;

@end

@interface LabelModuleProgress : UILabel

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

    - (void)setupStyle;
    - (void)styleOnProgress;
    - (void)styleComplete;
    - (void)styleDisable;

@end
