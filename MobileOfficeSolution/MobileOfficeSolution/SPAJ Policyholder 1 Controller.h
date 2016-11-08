//
//  SPAJ Policy Holder 1 Controller.h
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 11/1/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Dimension.h"


// PROTOCOL

@protocol SPAJPolicyholder1ControllerDelegate

    - (void) headerShowByScroll: (int) intScrollOffsetPage intScrollOffsetCurrent : (int) intScrollOffsetCurrent;

@end


// INTERFACE

@interface SPAJPolicyholder1Controller : UIViewController <UIScrollViewDelegate>

    /* PROTOCOL */

    @property (nonatomic,strong) id <SPAJPolicyholder1ControllerDelegate> spajPolicyholder1ControllerDelegate;

    /* LABEL */

    @property (nonatomic, weak) IBOutlet UILabel *labelSection;

    @property (nonatomic, weak) IBOutlet UILabel *labelNumber1;
    @property (nonatomic, weak) IBOutlet UILabel *labelNumber2;
    @property (nonatomic, weak) IBOutlet UILabel *labelNumber3;
    @property (nonatomic, weak) IBOutlet UILabel *labelNumber4;
    @property (nonatomic, weak) IBOutlet UILabel *labelNumber5;
    @property (nonatomic, weak) IBOutlet UILabel *labelNumber6;
    @property (nonatomic, weak) IBOutlet UILabel *labelNumber7;

    @property (nonatomic, weak) IBOutlet UILabel *labelQuestionName;
    @property (nonatomic, weak) IBOutlet UILabel *labelQuestionSex;
    @property (nonatomic, weak) IBOutlet UILabel *labelQuestionBirthPlace;
    @property (nonatomic, weak) IBOutlet UILabel *labelQuestionBirthDate;
    @property (nonatomic, weak) IBOutlet UILabel *labelQuestionIDType;
    @property (nonatomic, weak) IBOutlet UILabel *labelQuestionIDNumber;
    @property (nonatomic, weak) IBOutlet UILabel *labelQuestionNationality;
    @property (nonatomic, weak) IBOutlet UILabel *labelQuestionMaritalStatus;
    @property (nonatomic, weak) IBOutlet UILabel *labelQuestionReligion;
    @property (nonatomic, weak) IBOutlet UILabel *labelQuestionHandphone1;
    @property (nonatomic, weak) IBOutlet UILabel *labelQuestionHandphone2;
    @property (nonatomic, weak) IBOutlet UILabel *labelQuestionEmail;

    /* BUTTON */

    @property (nonatomic, weak) IBOutlet UIButton *buttonNext;

    /* SCROLL VIEW */

    @property (nonatomic, weak) IBOutlet UIScrollView *scrollViewContent;

    /* STACK VIEW */

    @property (nonatomic, weak) IBOutlet UIStackView *stackViewContent;

@end
