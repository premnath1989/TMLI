//
//  Navigation Controller.h
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/29/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "User Interface.h"
#import "LoginDBManagement.h"


// INTERFACE

@interface NavigationController : UIViewController

    /* LABEL */

    @property (nonatomic, weak) IBOutlet UILabel *labelName;
    @property (nonatomic, weak) IBOutlet UILabel *labelPosition;


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


    /* IMAGE */

    @property (nonatomic, weak) IBOutlet UIImageView *imageViewExpandSales;


    /* OBJECT */

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;


    /* STORYBOARD */

    @property (nonatomic, copy, readwrite) IBOutlet UIStoryboard *storyboardMain;
    @property (nonatomic, copy, readwrite) IBOutlet UIStoryboard *storyboardSPAJ;

@end
