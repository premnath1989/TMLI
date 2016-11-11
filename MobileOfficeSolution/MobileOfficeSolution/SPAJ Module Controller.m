//
//  SPAJ Module Controller.m
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 11/4/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import "SPAJ Module Controller.h"
#import "Navigation Controller.h"
#import "Descriptor Controller.h"
#import "SPAJ Add New Controller.h"
#import "Dimension.h"


// INTERFACE

@interface SPAJModuleController () <moduleControllerDelegate>

@end


// IMPLEMENTATION

@implementation SPAJModuleController

    /* VIEW DID LOAD */

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
        // DECLARATION
        
        _objectUserInterface = [[UserInterface alloc] init];
        
        _arrayModuleController = [[NSMutableArray alloc] initWithCapacity:8];
        
        _moduleController1 = [[ModuleController alloc] initWithNibName:@"Module View" bundle:nil];
        _moduleController2 = [[ModuleController alloc] initWithNibName:@"Module View" bundle:nil];
        _moduleController3 = [[ModuleController alloc] initWithNibName:@"Module View" bundle:nil];
        _moduleController4 = [[ModuleController alloc] initWithNibName:@"Module View" bundle:nil];
        _moduleController5 = [[ModuleController alloc] initWithNibName:@"Module View" bundle:nil];
        _moduleController6 = [[ModuleController alloc] initWithNibName:@"Module View" bundle:nil];
        _moduleController7 = [[ModuleController alloc] initWithNibName:@"Module View" bundle:nil];
        _moduleController8 = [[ModuleController alloc] initWithNibName:@"Module View" bundle:nil];
        _moduleController9 = [[ModuleController alloc] initWithNibName:@"Module View" bundle:nil];
        
        [_moduleController1 initialize:NSLocalizedString(@"MODULE_TITLE_SI", nil) stringHeader1:NSLocalizedString(@"MODULE_HEADER1_SI", nil) stringDetail1:@"1234567890" stringHeader2:NSLocalizedString(@"MODULE_HEADER2_SI", nil) stringDetail2:@"Andy Phan Chee Seng" intStateCurrent:5 intStateComplete:5 booleanDetail:true booleanState:true];
        [_arrayModuleController addObject:_moduleController1];
        [_moduleController2 initialize:NSLocalizedString(@"MODULE_TITLE_FNA", nil) stringHeader1:NSLocalizedString(@"MODULE_HEADER1_FNA", nil) stringDetail1:@"2345678901" stringHeader2:NSLocalizedString(@"MODULE_HEADER2_FNA", nil) stringDetail2:@"Andy Phan Chee Seng" intStateCurrent:5 intStateComplete:5 booleanDetail:true booleanState:true];
        [_arrayModuleController addObject:_moduleController2];
        [_moduleController3 initialize:NSLocalizedString(@"MODULE_TITLE_FORM", nil) stringHeader1:nil stringDetail1:nil stringHeader2:nil stringDetail2:nil intStateCurrent:1 intStateComplete:5 booleanDetail:false booleanState:true];
        [_arrayModuleController addObject:_moduleController3];
        [_moduleController4 initialize:NSLocalizedString(@"MODULE_TITLE_GENERATE", nil) stringHeader1:nil stringDetail1:nil stringHeader2:nil stringDetail2:nil intStateCurrent:-1 intStateComplete:5 booleanDetail:false booleanState:true];
        [_arrayModuleController addObject:_moduleController4];
        [_moduleController5 initialize:NSLocalizedString(@"MODULE_TITLE_ATTACHMENT", nil) stringHeader1:nil stringDetail1:nil stringHeader2:nil stringDetail2:nil intStateCurrent:-1 intStateComplete:5 booleanDetail:false booleanState:true];
        [_arrayModuleController addObject:_moduleController5];
        [_moduleController6 initialize:NSLocalizedString(@"MODULE_TITLE_SIGNATURE", nil) stringHeader1:nil stringDetail1:nil stringHeader2:nil stringDetail2:nil intStateCurrent:-1 intStateComplete:5 booleanDetail:false booleanState:true];
        [_arrayModuleController addObject:_moduleController6];
        [_moduleController7 initialize:NSLocalizedString(@"MODULE_TITLE_CONFIRMATION", nil) stringHeader1:nil stringDetail1:nil stringHeader2:nil stringDetail2:nil intStateCurrent:-1 intStateComplete:5 booleanDetail:false booleanState:true];
        [_arrayModuleController addObject:_moduleController7];
        [_moduleController8 initialize:NSLocalizedString(@"MODULE_TITLE_PAYMENT", nil) stringHeader1:nil stringDetail1:nil stringHeader2:nil stringDetail2:nil intStateCurrent:-1 intStateComplete:5 booleanDetail:false booleanState:true];
        [_arrayModuleController addObject:_moduleController8];
        [_moduleController9 initialize:NSLocalizedString(@"MODULE_TITLE_REPORT", nil) stringHeader1:nil stringDetail1:nil stringHeader2:nil stringDetail2:nil intStateCurrent:-1 intStateComplete:5 booleanDetail:false booleanState:true];
        [_arrayModuleController addObject:_moduleController9];
        
        
        // LAYOUT
        
        [_imageViewHeader setImage:[UIImage imageNamed:@"photo_spaj_primary"]];
        
            /* INCLUDE */
        
            DescriptorController *viewDescriptorController = [[DescriptorController alloc] initWithNibName:@"Descriptor View" bundle:nil];
            viewDescriptorController.view.frame = _viewDescriptor.bounds;
            [self addChildViewController:viewDescriptorController];
            [self.viewDescriptor addSubview:viewDescriptorController.view];
        
            NavigationController *viewNavigationController = [[NavigationController alloc] initWithNibName:@"Navigation View" bundle:nil];
            viewNavigationController.view.frame = _viewNavigation.bounds;
            [self addChildViewController:viewNavigationController];
            [self.viewNavigation addSubview:viewNavigationController.view];
        
            /* MODULE */
            
            for (int i = 0; i < [_arrayModuleController count]; i++)
            {
                if ([[_arrayModuleController objectAtIndex:i] booleanState] == true)
                {
                    ViewModule *viewModule = [[ViewModule alloc] init];
                    [viewModule setupStyle];
                    [viewModule.widthAnchor constraintEqualToConstant:_scrollViewModule.bounds.size.width].active = true;
                    [_stackViewModule addArrangedSubview:viewModule];
                    
                    ModuleController *viewModuleController = [[_arrayModuleController objectAtIndex:i] initWithNibName:@"Module View" bundle:nil];
                    viewModuleController.view.frame = viewModule.bounds;
                    viewModuleController.moduleControllerDelegate = self;
                    [self addChildViewController:viewModuleController];
                    [viewModule addSubview:viewModuleController.view];
                    
                    [viewModuleController refreshView];
                }
                else
                {
                    
                }
            }
        
        
        // LOCALIZABLE
        
        _labelPhotoHeader.text = NSLocalizedString(@"HEADER_SPAJ_MODULE", nil);
        _labelPhotoDetail.text = NSLocalizedString(@"DETAIL_SPAJ_MODULE", nil);
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


    /* FUNCTION */

    - (void) goToSPAJAddNew
    {
        SPAJAddNewController *viewSPAJAddNewController = [[SPAJAddNewController alloc] init];
        [self presentViewController:viewSPAJAddNewController animated:YES completion:nil ];
    }

@end
