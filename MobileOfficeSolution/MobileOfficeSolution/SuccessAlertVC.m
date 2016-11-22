//
//  SuccessAlertVC.m
//  MobileOfficeSolution
//
//  Created by Emi on 22/11/16.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import "SuccessAlertVC.h"
#import "AppDelegate.h"
#import "MainClient.h"
#import "MainScreen.h"


@interface SuccessAlertVC ()

@end

@implementation SuccessAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)ActionOK:(id)sender {
    
    UIStoryboard *cpStoryboard = [UIStoryboard storyboardWithName:@"ProspectProfileStoryboard" bundle:Nil];
    AppDelegate *appdlg = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    MainClient *mainClient = [cpStoryboard instantiateViewControllerWithIdentifier:@"newClientListing"];
    mainClient.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:mainClient animated:NO completion:Nil];
    appdlg = Nil;
    mainClient= Nil;
    
    
}
@end
