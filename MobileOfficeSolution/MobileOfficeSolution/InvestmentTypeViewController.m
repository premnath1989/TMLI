//
//  InvestmentTypeViewController.m
//  MobileOfficeSolution
//
//  Created by Emi on 28/12/16.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import "InvestmentTypeViewController.h"

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
    
    return [FundList count];
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
    
   
    return cell;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
