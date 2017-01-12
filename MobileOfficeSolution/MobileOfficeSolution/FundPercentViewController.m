//
//  FundPercentViewController.m
//  MobileOfficeSolution
//
//  Created by Emi on 6/1/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "FundPercentViewController.h"
#import "Formatter.h"

@interface FundPercentViewController ()<UITextFieldDelegate>{
    Formatter* formatter;
}

@end

@implementation FundPercentViewController
@synthesize UDInvest, InvestList,delegate;

NSString *FundName;
NSString *Komposisi;

-(void)viewWillAppear:(BOOL)animated{
    FundName = [UDInvest valueForKey:@"FundName"];
    
    _lblFundName.text = FundName;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    formatter = [[Formatter alloc]init];
    UDInvest = [[NSMutableDictionary alloc]init];
    
    [_TxtPercentage setDelegate:self];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
//    if ((textField == textFixedIncome)||(textField == textEquityIncome ))
//    {
        //KY - IMPORTANT - PUT THIS LINE TO DETECT THE FIRST CHARACTER PRESSED....
        //This method is being called before the content of textField.text is changed.
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return (([string isEqualToString:filtered])&&(newLength <= 3));
        
//    }
    return YES;*/
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //first, check if the new string is numeric only. If not, return NO;
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789,."] invertedSet];
    if ([newString rangeOfCharacterFromSet:characterSet].location != NSNotFound)
    {
        return NO;
    }
    
    return [newString doubleValue] < 101;
}
- (IBAction)ActionOK:(id)sender {
    
    //UDInvest = [NSUserDefaults standardUserDefaults];
    
    InvestList = [NSMutableArray array];
    
    NSMutableArray *tempArr = [UDInvest objectForKey:@"InvestArray"];
    InvestList = [tempArr mutableCopy];
    
    Komposisi = _TxtPercentage.text;
    
    NSDictionary *tempData = [[NSDictionary alloc] initWithObjectsAndKeys:FundName, @"FundName", Komposisi, @"Komposisi", nil];
    //check if same fund name already exist
    if ([InvestList count] != 0) {
        /*int count = InvestList.count-1;
        for (int i = 0; i <= count; i++) {
            NSString *strFundName = [[InvestList objectAtIndex:i] objectForKey:@"FundName"];
            if ([FundName isEqualToString:strFundName]) {
                [InvestList removeObjectAtIndex:i];
            }
        }*/
        if ([[InvestList valueForKey:@"FundName"] containsObject:FundName]){
            int index = [[InvestList valueForKey:@"FundName"] indexOfObject:FundName];
            [InvestList replaceObjectAtIndex:index withObject:tempData];
        }
        else{
            [InvestList addObject:[tempData copy]];
        }
    }
    
    [UDInvest setObject:InvestList forKey:@"InvestArray"];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"LoadInvestTable" object:nil];
    [delegate LoadInvestTable:UDInvest];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)ActionCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
