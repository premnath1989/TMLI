//
//  ViewController.h
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/27/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "User Interface.h"
#import "Navigation Controller.h"
#import "AppDelegate.h"



// INTERFACE

@interface LoginController : UIViewController

    /* IMAGE VIEW */

    @property (nonatomic, weak) IBOutlet UIImageView *imageViewBackground;

    /* VIEW */

    @property (nonatomic, weak) IBOutlet UIView *viewDescriptor;
    @property (nonatomic, weak) IBOutlet UIView *viewNavigation;
    @property (nonatomic, weak) IBOutlet UIView *viewMain;

    /* TEXTFIELD */

    @property (nonatomic, weak) IBOutlet UITextField *textFieldUserCode;
    @property (nonatomic, weak) IBOutlet UITextField *textFieldUserPassword;

    /* BUTTON */

    @property (nonatomic, weak) IBOutlet UIButton *buttonLogin;
    @property (nonatomic, weak) IBOutlet UIButton *buttonForgotPassword;

    /* LABEL */

    @property (nonatomic, weak) IBOutlet UILabel *labelSectionLogin;
    @property (nonatomic, weak) IBOutlet UILabel *labelSectionInformation;

    @property (nonatomic, weak) IBOutlet UILabel *labelParagraphInformation;

    /* OBJECT */

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

@end
