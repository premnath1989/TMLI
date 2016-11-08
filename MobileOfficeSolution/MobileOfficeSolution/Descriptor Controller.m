//
//  Descriptor Controller.m
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/27/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import "Descriptor Controller.h"


// INTERFACE

@interface DescriptorController ()

@end


// IMPLEMENTATION

@implementation DescriptorController

    /* VIEW DID LOAD */

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
        // LOCALIZABLE
        
        _labelDescriptorHeader.text = NSLocalizedString(@"DECORATOR_DESCRIPTOR_HEADER", nil);
        _labelDescriptorWebsite.text = NSLocalizedString(@"DECORATOR_DESCRIPTOR_WEBSITE", nil);
        _labelDescriptorDetail.text = NSLocalizedString(@"DECORATOR_DESCRIPTOR_DETAIL", nil);
    }

    /* DID RECEIVE MEMORY WARNING */

    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

@end
