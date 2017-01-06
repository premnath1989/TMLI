//
//  FundPercentViewController.m
//  MobileOfficeSolution
//
//  Created by Emi on 6/1/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "FundPercentViewController.h"

@interface FundPercentViewController ()

@end

@implementation FundPercentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _lblFundName.text = @"TMEquityAggressiveFund";
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)ActionOK:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)ActionCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
