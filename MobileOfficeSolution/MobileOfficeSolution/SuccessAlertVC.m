//
//  SuccessAlertVC.m
//  MobileOfficeSolution
//
//  Created by Emi on 22/11/16.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import "SuccessAlertVC.h"
#import "AppDelegate.h"
#import "MainScreen.h"


@interface SuccessAlertVC ()

@end

@implementation SuccessAlertVC
@synthesize UDScore;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UDScore = [NSUserDefaults standardUserDefaults];
    
    int totalScore = [[UDScore stringForKey:@"Score"] integerValue];
    _lblScore.text = [NSString stringWithFormat:@"%d", totalScore];
    
    
    if (totalScore < 15) {
       _LblGroup.text = @"COLD";
        _LblGroup.textColor = [UIColor blueColor];
        [_ViewScore setBackgroundColor:[UIColor blueColor]];
    }
    else if (totalScore > 15 && totalScore < 23) {
        _LblGroup.text = @"WARM";
        _LblGroup.textColor = [UIColor orangeColor];
        [_ViewScore setBackgroundColor:[UIColor orangeColor]];
    }
    else if (totalScore > 23 && totalScore < 31) {
        _LblGroup.text = @"HOT";
        _LblGroup.textColor = [UIColor redColor];
        [_ViewScore setBackgroundColor:[UIColor redColor]];
    }
    else {
        _LblGroup.text = @"";
        _LblGroup.textColor = [UIColor blueColor];
        [_ViewScore setBackgroundColor:[UIColor blackColor]];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)ActionOK:(id)sender {
    
//    UIStoryboard *cpStoryboard = [UIStoryboard storyboardWithName:@"ProspectProfileStoryboard" bundle:Nil];
//    AppDelegate *appdlg = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
//    MainClient *mainClient = [cpStoryboard instantiateViewControllerWithIdentifier:@"newClientListing"];
//    mainClient.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:mainClient animated:NO completion:Nil];
//    appdlg = Nil;
//    mainClient= Nil;
    
    
}
@end
