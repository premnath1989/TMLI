//
//  Home Controller.h
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/27/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "User Interface.h"


// INTERFACE

@interface HomeController : UIViewController <UIScrollViewDelegate>

    /* LABEL */

    @property (nonatomic, weak) IBOutlet UILabel *labelName;
    @property (nonatomic, weak) IBOutlet UILabel *labelPosition;

    /* SCROLL VIEW */

    @property (nonatomic, weak) IBOutlet UIScrollView *scrollViewSliderNews;

    /* BUTTON */

    @property (nonatomic, weak) IBOutlet UIButton *buttonHome;
    @property (nonatomic, weak) IBOutlet UIButton *buttonAgent;
    @property (nonatomic, weak) IBOutlet UIButton *buttonLogout;

    @property (nonatomic, weak) IBOutlet UIButton *buttonHeaderProspect;
    @property (nonatomic, weak) IBOutlet UIButton *buttonHeaderCalendar;
    @property (nonatomic, weak) IBOutlet UIButton *buttonHeaderSales;
    @property (nonatomic, weak) IBOutlet UIButton *buttonHeaderActivityManagement;
    @property (nonatomic, weak) IBOutlet UIButton *buttonHeaderEPayment;
    @property (nonatomic, weak) IBOutlet UIButton *buttonHeaderELibrary;
    @property (nonatomic, weak) IBOutlet UIButton *buttonHeaderReport;

    @property (nonatomic, weak) IBOutlet UIButton *buttonDetailProspect;
    @property (nonatomic, weak) IBOutlet UIButton *buttonDetailFNA;
    @property (nonatomic, weak) IBOutlet UIButton *buttonDetailSI;
    @property (nonatomic, weak) IBOutlet UIButton *buttonDetailSPAJ;
    @property (nonatomic, weak) IBOutlet UIButton *buttonDetailPolicyReceipt;

    /* STACKVIEW */

    @property (nonatomic, weak) IBOutlet UIStackView *stackViewSales;
    @property (nonatomic, weak) IBOutlet UIStackView *stackViewSliderController;

    /* VIEW */

    @property (nonatomic, weak) IBOutlet UIView *viewSliderController;

    /* ARRAY IMAGE */

    @property (nonatomic, copy, readwrite) NSArray *arrayImage;

    /* OBJECT */

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

    /* STORYBOARD */

    @property (nonatomic, copy, readwrite) IBOutlet UIStoryboard *storyboardMain;
    @property (nonatomic, copy, readwrite) IBOutlet UIStoryboard *storyboardSPAJ;

@end
