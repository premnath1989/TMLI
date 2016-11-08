//
//  SPAJ Landing Controller.h
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/29/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPRT

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "User Interface.h"


// INTERFACE

@interface SPAJLandingController : UIViewController

    /* VIEW */

    @property (nonatomic, weak) IBOutlet UIView *viewDescriptor;
    @property (nonatomic, weak) IBOutlet UIView *viewNavigation;
    @property (nonatomic, weak) IBOutlet UIView *viewMain;

    /* IMAGE VIEW */

    @property (nonatomic, weak) IBOutlet UIImageView *imageViewBackground;

    /* LABEL */

    @property (nonatomic, weak) IBOutlet UILabel *labelPhotoHeader;
    @property (nonatomic, weak) IBOutlet UILabel *labelPhotoDetail;

    /* BUTTON */

    @property (nonatomic, weak) IBOutlet UIButton *buttonAddNew;
    @property (nonatomic, weak) IBOutlet UIButton *buttonExistingList;
    @property (nonatomic, weak) IBOutlet UIButton *buttonNavigation;

    /* OBJECT */

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

@end
