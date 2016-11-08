//
//  SPAJ Add New Controller.h
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/31/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "User Interface.h"
#import "Guide Header Controller_design.h"
#import "Guide Helper.h"


// INTERFACE

@interface SPAJAddNewController : UIViewController

    /* VIEW */

    @property (nonatomic, weak) IBOutlet UIView *viewNavigation;
    @property (nonatomic, weak) IBOutlet UIView *viewMain;
    @property (nonatomic, weak) IBOutlet UIView *viewContent;
    @property (nonatomic, weak) IBOutlet UIView *viewHeaderThick;
    @property (nonatomic, weak) IBOutlet UIView *viewHeaderThin;

    /* IMAGE VIEW */

    @property (nonatomic, weak) IBOutlet UIImageView *imageViewHeader;

    /* LABEL */

    @property (nonatomic, weak) IBOutlet UILabel *labelPhotoHeader;
    @property (nonatomic, weak) IBOutlet UILabel *labelPhotoDetail;
    @property (nonatomic, weak) IBOutlet UILabel *labelHeaderTitle;

    /* BUTTON */

    @property (nonatomic, weak) IBOutlet UIButton *buttonHeader;
    @property (nonatomic, weak) IBOutlet UIButton *buttonNavigation;

    /* STACKVIEW */

    @property (nonatomic, weak) IBOutlet UIStackView *stackViewGuideHeader;
    @property (nonatomic, weak) IBOutlet UIStackView *stackViewGuideDetail;

    /* OBJECT */

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;
    @property (nonatomic, copy, readwrite) GuideHelper *objectGuideHelper;

    @property (nonatomic, copy, readwrite) GuideHeaderController *guideHeaderController1;
    @property (nonatomic, copy, readwrite) GuideHeaderController *guideHeaderController2;
    @property (nonatomic, copy, readwrite) GuideHeaderController *guideHeaderController3;
    @property (nonatomic, copy, readwrite) GuideHeaderController *guideHeaderController4;
    @property (nonatomic, copy, readwrite) GuideHeaderController *guideHeaderController5;
    @property (nonatomic, copy, readwrite) GuideHeaderController *guideHeaderController6;

    /* ARRAY */

    @property (nonatomic, strong) NSMutableArray *arrayGuideHeaderController;

@end
