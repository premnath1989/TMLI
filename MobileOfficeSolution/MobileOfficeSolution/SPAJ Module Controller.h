//
//  SPAJ Module Controller.h
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 11/4/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "User Interface.h"
#import "Module Controller.h"


// INTERFACE

@interface SPAJModuleController : UIViewController

    /* VIEW */

    @property (nonatomic, weak) IBOutlet UIView *viewNavigation;
    @property (nonatomic, weak) IBOutlet UIView *viewMain;
    @property (nonatomic, weak) IBOutlet UIView *viewDescriptor;

    /* IMAGE VIEW */

    @property (nonatomic, weak) IBOutlet UIImageView *imageViewHeader;

    /* LABEL */

    @property (nonatomic, weak) IBOutlet UILabel *labelPhotoHeader;
    @property (nonatomic, weak) IBOutlet UILabel *labelPhotoDetail;

    /* SCROLL VIEW */

    @property (nonatomic, weak) IBOutlet UIScrollView *scrollViewModule;

    /* STACK VIEW */

    @property (nonatomic, weak) IBOutlet UIStackView *stackViewModule;

    /* OBJECT */

    @property (nonatomic, copy, readwrite) UserInterface *objectUserInterface;

    @property (nonatomic, copy, readwrite) ModuleController *moduleController1;
    @property (nonatomic, copy, readwrite) ModuleController *moduleController2;
    @property (nonatomic, copy, readwrite) ModuleController *moduleController3;
    @property (nonatomic, copy, readwrite) ModuleController *moduleController4;
    @property (nonatomic, copy, readwrite) ModuleController *moduleController5;
    @property (nonatomic, copy, readwrite) ModuleController *moduleController6;
    @property (nonatomic, copy, readwrite) ModuleController *moduleController7;
    @property (nonatomic, copy, readwrite) ModuleController *moduleController8;
    @property (nonatomic, copy, readwrite) ModuleController *moduleController9;

    /* ARRAY */

    @property (nonatomic, strong) NSMutableArray *arrayModuleController;

@end
