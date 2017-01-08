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
@synthesize UDInvest, FundList, InvestList, lblTotal;

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoadInvestTable) name:@"LoadInvestTable" object:nil];
    // Do any additional setup after loading the view.
    UDInvest = [NSUserDefaults standardUserDefaults];
    
    [self loadFundData];
    
    //not sure this needed or not, but need to clear if new, call back from DB if edit
    InvestList = [NSMutableArray array];
    [InvestList removeAllObjects];
     [UDInvest setObject:InvestList forKey:@"InvestArray"];
    
    lblTotal.text = @"Total: 0%";

    
}

-(void)loadFundData
{

    //temp set product type:
    NSString *productType = @"TM Link (Wealth Enhancement)";
    
    if ([productType isEqualToString:@""]) {
        FundList = [NSMutableArray arrayWithObjects:@"TMBalanceFund",@"TMEquityFund",@"TMCashFund",@"TMEquityAggressiveFund", nil];
    }
    else if ([productType isEqualToString:@"ProteksiKu"]) {
        FundList = [NSMutableArray arrayWithObjects:@"TM Bond Fund",
                    @"TM Equity Fund",
                    @"TM Equity Aggressive Fund",
                    @"TM Balanced Fund",
                    @"TM Cash Fund", nil];
    }
    else if ([productType isEqualToString:@"InvestasiKu"]) {
        FundList = [NSMutableArray arrayWithObjects:@"TM Bond Fund",
                    @"TM Equity Fund",
                    @"TM Equity Aggressive Fund",
                    @"TM Balanced Fund",
                    @"TM Cash Fund", nil];
    }
    else if ([productType isEqualToString:@"TM Link (Wealth Enhancement)"]) {
        FundList = [NSMutableArray arrayWithObjects:@"TM syCash Fund",
                    @"TM syEquity Fund",
                    @"TM syBond Fund",
                    @"TM syManaged Fund",
                    @"TM Equity Fund",
                    @"TM Equity Aggressive Fund",
                    @"TM Bond Fund",
                    @"TM Balanced Fund",
                    @"TM Cash Fund", nil];
    }
    
    
    [_FundTypeTableView reloadData];
}

-(void) LoadInvestTable {
 
    UDInvest = [NSUserDefaults standardUserDefaults];
    InvestList = [NSMutableArray array];
    [InvestList removeAllObjects];
    InvestList = [UDInvest objectForKey:@"InvestArray"];
    
    [_InvestasiTableView reloadData];
    
    [self CalculateTotal];
    
}

-(void) CalculateTotal {
    int Total = 0;
    int komp =0;
    for (int i = 0; i <= InvestList.count-1; i++) {
        komp = [[[InvestList objectAtIndex:i] objectForKey:@"Komposisi"] intValue];
        Total = Total + komp;
    }
    lblTotal.text = [NSString stringWithFormat:@"Total: %d %%", Total];
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
    else if([myTableView isEqual:_InvestasiTableView]) {
        return [InvestList count];
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
        
        CGRect frame=CGRectMake(25,0, 230, 55);
        UILabel *label1=[[UILabel alloc]init];
        label1.frame=frame;
        label1.textAlignment = NSTextAlignmentLeft;
        label1.tag = 13001;
        label1.backgroundColor = [UIColor clearColor];
        [label1 setFont:[UIFont systemFontOfSize:15]];
        [cell.contentView addSubview:label1];
        

        label1.text = [[InvestList objectAtIndex:indexPath.row] objectForKey:@"FundName"];
        
        CGRect frame2=CGRectMake(400,0, 100, 55);
        UILabel *label2=[[UILabel alloc]init];
        label2.frame=frame2;
        label2.textAlignment = NSTextAlignmentRight;
        label2.tag = 13002;
        label2.backgroundColor = [UIColor clearColor];
        [label2 setFont:[UIFont systemFontOfSize:15]];
        [cell.contentView addSubview:label2];
        
        label2.text = [NSString stringWithFormat:@"%@ %%", [[InvestList objectAtIndex:indexPath.row] objectForKey:@"Komposisi"]];
    }
    

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _cellText = cell.textLabel.text;
    
    UDInvest =  [NSUserDefaults standardUserDefaults];
    
    if([tableView isEqual:_FundTypeTableView]) {
        
        [UDInvest setObject:_cellText forKey:@"FundName"];
        
    }
    else if ([tableView isEqual:_InvestasiTableView])
    {
        [UDInvest setObject:[[InvestList objectAtIndex:indexPath.row] objectForKey:@"FundName"] forKey:@"FundName"];
    }

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
