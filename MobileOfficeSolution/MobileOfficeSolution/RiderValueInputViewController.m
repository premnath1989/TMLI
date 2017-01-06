//
//  RiderValueInputViewController.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/6/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "RiderValueInputViewController.h"

@interface RiderValueInputViewController ()

@end

@implementation RiderValueInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setRiderDetailInformation:(NSString *)stringRiderName StringRiderValue:(NSString *)stringRiderValue{
    [labelRiderName setText:stringRiderName];
    [textRiderValue setText:stringRiderValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)actionCancelRiderValueInput:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)actionSaveRiderValueInput:(id)sender{
    [_delegate saveRiderInput:labelRiderName.text RiderValue:textRiderValue.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
