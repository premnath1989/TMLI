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
@synthesize UDInvest, InvestList;

NSString *FundName;
NSString *Komposisi;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UDInvest = [NSUserDefaults standardUserDefaults];
    
    FundName = [UDInvest stringForKey:@"FundName"];
    
    _lblFundName.text = FundName;
    
}

- (IBAction)ActionOK:(id)sender {
    
    UDInvest = [NSUserDefaults standardUserDefaults];
    
    InvestList = [NSMutableArray array];
    
    NSMutableArray *tempArr = [UDInvest objectForKey:@"InvestArray"];
    InvestList = [tempArr mutableCopy];
    
    Komposisi = _TxtPercentage.text;
    
    //check if same fund name already exist
    if ([InvestList count] != 0) {
        int count = InvestList.count-1;
        for (int i = 0; i <= count; i++) {
            NSString *strFundName = [[InvestList objectAtIndex:i] objectForKey:@"FundName"];
            if ([FundName isEqualToString:strFundName]) {
                [InvestList removeObjectAtIndex:i];
            }
        }
    }
    
    
    NSDictionary *tempData = [[NSDictionary alloc] initWithObjectsAndKeys:FundName, @"FundName", Komposisi, @"Komposisi", nil];
    [InvestList addObject:[tempData copy]];
    
    [UDInvest setObject:InvestList forKey:@"InvestArray"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadInvestTable" object:nil];
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
