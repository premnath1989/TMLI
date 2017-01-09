//
//  SPAJ Landing Controller.m
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/29/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import "SPAJ Landing Controller.h"
#import "Descriptor Controller.h"
#import "Navigation Controller.h"


// INTERFACE

@interface SPAJLandingController ()

@end


// IMPLEMENTATION

@implementation SPAJLandingController

    /* VIEW DID LOAD */

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
        // DECLARATION
        
        _objectUserInterface = [[UserInterface alloc] init];
        
        NSString *documentdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *imgPath = [documentdir stringByAppendingPathComponent:@"backgroundImages/SPAJModulePage.png"];
        NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
        UIImage *thumbNail = [[UIImage alloc] initWithData:imgData];
        // LAYOUT
        
        [_imageViewBackground setImage:thumbNail];
        
            /* INCLUDE */
            
            DescriptorController *viewDescriptorController = [[DescriptorController alloc] initWithNibName:@"Descriptor View" bundle:nil];
            viewDescriptorController.view.frame = _viewDescriptor.bounds;
            [self addChildViewController:viewDescriptorController];
            [self.viewDescriptor addSubview:viewDescriptorController.view];
        
            NavigationController *viewNavigationController = [[NavigationController alloc] initWithNibName:@"Navigation View" bundle:nil];
            viewNavigationController.view.frame = _viewNavigation.bounds;
            [self addChildViewController:viewNavigationController];
            [self.viewNavigation addSubview:viewNavigationController.view];
        
        
        // LOCALIZABLE
        
        _labelPhotoHeader.text = NSLocalizedString(@"HEADER_SPAJ_LANDING", nil);
        _labelPhotoDetail.text = NSLocalizedString(@"DETAIL_SPAJ_LANDING", nil);
        
        [_buttonAddNew setTitle:NSLocalizedString(@"BUTTON_PHOTO_ADDNEW", nil) forState:UIControlStateNormal];
        [_buttonExistingList setTitle:NSLocalizedString(@"BUTTON_PHOTO_EXISTINGLIST", nil) forState:UIControlStateNormal];
    }


    /* DID RECEIVE MEMORY WARNING */

    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }


    /* IBACTION */

    - (IBAction)navigationShow:(id)sender
    {
        [_objectUserInterface navigationShow:self];
    }

@end
