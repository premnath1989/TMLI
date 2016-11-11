//
//  ViewController.m
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/27/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import "Login Controller.h"
#import "Descriptor Controller.h"


// INTERFACE

@interface LoginController ()

@end


// IMPLEMENTATION

@implementation LoginController

    /* VIEW DID LOAD */

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // DECLARATION
        
        _objectUserInterface = [[UserInterface alloc] init];
        
        
        // LAYOUT
        
        [_imageViewBackground setImage:[UIImage imageNamed:@"photo_login_tertiary"]];
        
        /* INCLUDE */
        
        DescriptorController *viewDescriptorController = [[DescriptorController alloc] initWithNibName:@"Descriptor View" bundle:nil];
        viewDescriptorController.view.frame = _viewDescriptor.bounds;
        [self addChildViewController:viewDescriptorController];
        [_viewDescriptor addSubview:viewDescriptorController.view];
        
        
        // LOCALIZABLE
        
        _labelSectionInformation.text = NSLocalizedString(@"FORM_SECTION_INFORMATION", nil);
        _labelSectionLogin.text = NSLocalizedString(@"FORM_SECTION_LOGIN", nil);
        
        _labelParagraphInformation.text = NSLocalizedString(@"FORM_PARAGRAPH_INFORMATION", nil);
        
        [_buttonLogin setTitle:NSLocalizedString(@"BUTTON_FORM_LOGIN", nil) forState:UIControlStateNormal];
        [_buttonForgotPassword setTitle:NSLocalizedString(@"BUTTON_PHOTO_FORGOTPASSWORD", nil) forState:UIControlStateNormal];
        
        _textFieldUserCode.text = NSLocalizedString(@"PLACEHOLDER_TEXTFIELD_USERCODE", nil);
        _textFieldUserPassword.text = NSLocalizedString(@"PLACEHOLDER_TEXTFIELD_PASSWORD", nil);
        
        
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [self.view addGestureRecognizer:gr];
    }



    - (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
        NSLog(@"got a tap, but not where i need it");
    }



    /* DID RECEIVE MEMORY WARNING */

    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }


    /* VIEW WILL APPEAR */

    - (void)viewWillAppear:(BOOL)animated
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    }


    /* VIEW WILL DISSAPEAR */

    - (void)viewWillDisappear:(BOOL)animated
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }

    - (IBAction)navigationShow:(id)sender
    {
        [_objectUserInterface navigationShow:self];
    }

    - (IBAction)navigationHide:(id)sender
    {
        [_objectUserInterface navigationHide:self];
    }


    /* KEYBOARD */

    - (void) keyboardShow: (NSNotification *) notificationKeyboard
    {
        [_objectUserInterface keyboardShow:notificationKeyboard viewMain:_viewMain];
    }

    - (void) keyboardHide: (NSNotification *) notificationKeyboard
    {
        [_objectUserInterface keyboardHide:notificationKeyboard viewMain:_viewMain];
    }

@end
