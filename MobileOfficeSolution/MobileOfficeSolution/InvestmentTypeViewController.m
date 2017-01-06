//
//  InvestmentTypeViewController.m
//  MobileOfficeSolution
//
//  Created by Emi on 28/12/16.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import "InvestmentTypeViewController.h"
#import "FundPercentViewController.h"

@interface InvestmentTypeViewController ()

@end

@implementation InvestmentTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    FundList = [NSMutableArray arrayWithObjects:@"TMBalanceFund",@"TMEquityFund",@"TMCashFund",@"TMEquityAggressiveFund", nil];
    
    [_FundTypeTableView reloadData];
    
    
}

-(void)loadFundData
{

    
     FundList = [NSMutableArray arrayWithObjects:@"TMBalanceFund",@"TMEquityFund",@"TMCashFund",@"TMEquityAggressiveFund", nil];
    
    [_FundTypeTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section
{
    if([myTableView isEqual:_FundTypeTableView]) {
        return [FundList count];
    }
    else {
        return 0;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    
    if([tableView isEqual:_FundTypeTableView])
    {
        cell.textLabel.text = [FundList objectAtIndex:indexPath.row];
    }
    else if ([tableView isEqual:_InvestasiTableView])
    {
        cell.textLabel.text = @"test               100%";
    }
    

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _cellText = cell.textLabel.text;
    
    [self FundPercent];
    
}

-(void) FundPercent {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"HLAWPStoryboard" bundle:nil];
    FundPercentViewController *FundVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FundPercent"];
    
    [self presentViewController:FundVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (IBAction)DoSave:(id)sender {
    

}
@end
