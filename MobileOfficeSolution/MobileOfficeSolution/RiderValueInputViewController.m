//
//  RiderValueInputViewController.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/6/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "RiderValueInputViewController.h"
#import "Formatter.h"

@interface RiderValueInputViewController (){
    Formatter* formatter;
    NSDictionary* dictRiderSelectedData;
}


@end

@implementation RiderValueInputViewController

- (void)viewDidLoad {
    formatter = [[Formatter alloc]init];
    
    [textRiderValue addTarget:self action:@selector(RealTimeFormat:) forControlEvents:UIControlEventEditingChanged];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setRiderDetailInformation:(NSDictionary *)dictRiderData StringRiderValue:(NSString *)stringRiderValue{
    dictRiderSelectedData = [[NSDictionary alloc]initWithDictionary:dictRiderData];
    [labelRiderName setText:[dictRiderData valueForKey:@"SI_RiderPlan_Desc"]];
    [textRiderValue setText:stringRiderValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    //    if ((textField == textTopUpAmount)||(textField == textWithDrawalAmount))
    //    {
    BOOL return13digit = FALSE;
    //KY - IMPORTANT - PUT THIS LINE TO DETECT THE FIRST CHARACTER PRESSED....
    //This method is being called before the content of textField.text is changed.
    NSString * AI = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([AI rangeOfString:@"."].length == 1) {
        NSArray  *comp = [AI componentsSeparatedByString:@"."];
        NSString *get_num = [[comp objectAtIndex:0] stringByReplacingOccurrencesOfString:@"," withString:@""];
        int c = [get_num length];
        return13digit = (c > 15);
        
    } else if([AI rangeOfString:@"."].length == 0) {
        NSArray  *comp = [AI componentsSeparatedByString:@"."];
        NSString *get_num = [[comp objectAtIndex:0] stringByReplacingOccurrencesOfString:@"," withString:@""];
        int c = [get_num length];
        return13digit = (c  > 15);
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if( return13digit == TRUE) {
        return (([string isEqualToString:filtered])&&(newLength <= 15));
    } else {
        return (([string isEqualToString:filtered])&&(newLength <= 19));
    }
    //    }
    return YES;
}

-(void)RealTimeFormat:(UITextField *)sender{
    NSNumber *plainNumber = [formatter convertAnyNonDecimalNumberToString:sender.text];
    [sender setText:[formatter numberToCurrencyDecimalFormatted:plainNumber]];
}

-(IBAction)actionCancelRiderValueInput:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)actionSaveRiderValueInput:(id)sender{
    [_delegate saveRiderInput:dictRiderSelectedData RiderValue:textRiderValue.text];
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
