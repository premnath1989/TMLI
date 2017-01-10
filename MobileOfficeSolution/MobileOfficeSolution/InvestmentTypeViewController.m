//
//  InvestmentTypeViewController.m
//  MobileOfficeSolution
//
//  Created by Emi on 28/12/16.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import "InvestmentTypeViewController.h"
#import "FundPercentViewController.h"
#import "ModelSIFundAllocation.h"

@interface InvestmentTypeViewController ()<FundPercentViewControllerDelegate>{
    ModelSIFundAllocation *modelSIFundAllocation;
}

@end

@implementation InvestmentTypeViewController
@synthesize  FundList, InvestList, lblTotal;
@synthesize _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoadInvestTable) name:@"LoadInvestTable" object:nil];
    // Do any additional setup after loading the view.
    UDInvest = [[NSMutableDictionary alloc]init];
    
    
    
    //not sure this needed or not, but need to clear if new, call back from DB if edit
    InvestList = [[NSMutableArray alloc]init];
    modelSIFundAllocation = [[ModelSIFundAllocation alloc]init];
    //[InvestList removeAllObjects];
     [UDInvest setObject:InvestList forKey:@"InvestArray"];
    
    lblTotal.text = @"Total: 0%";

    [self loadFundData];
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

-(void)LoadInvestTable:(NSMutableDictionary *)dictUDInvest{
 
    UDInvest = dictUDInvest;[NSUserDefaults standardUserDefaults];
    //InvestList = [[NSMutableArray alloc]init];
    //[InvestList removeAllObjects];
    InvestList = [[NSMutableArray alloc]initWithArray:[UDInvest valueForKey:@"InvestArray"]];
    
    [_InvestasiTableView reloadData];
    
    [self CalculateTotal];
    
}

-(void) CalculateTotal {
    int Total = 0;
    int komp =0;
    if (InvestList.count>0){
        for (int i = 0; i <= InvestList.count-1; i++) {
            komp = [[[InvestList objectAtIndex:i] objectForKey:@"Komposisi"] intValue];
            Total = Total + komp;
        }
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    UIView* selectedView = [[UIView alloc] initWithFrame:cell.frame];
    [selectedView setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:117.0/255.0 blue:134.0/255.0 alpha:1.0]];
    if([tableView isEqual:_FundTypeTableView])
    {
        cell.textLabel.text = [FundList objectAtIndex:indexPath.row];
    }
    else if ([tableView isEqual:_InvestasiTableView])
    {
        
        [[cell.contentView viewWithTag:13001] removeFromSuperview ];
        [[cell.contentView viewWithTag:13002] removeFromSuperview ];
        
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
    

    [cell.textLabel setFont:[UIFont fontWithName:@"NewJune-Regular" size:14.0]];
    [cell setSelectedBackgroundView:selectedView];
    
    if ((indexPath.row % 2) == 0){
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    else{
        [cell setBackgroundColor:[UIColor colorWithRed:231.0/255.0 green:233.0/255.0 blue:234.0/255.0 alpha:1.0]];
    }

    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    if (tableView == _FundTypeTableView){
        return NO;
    }
    else if (tableView == _InvestasiTableView){
        return YES;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _InvestasiTableView){
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [InvestList removeObjectAtIndex:indexPath.row];
            [_InvestasiTableView beginUpdates];
            [_InvestasiTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                    withRowAnimation:UITableViewRowAnimationFade];
            [_InvestasiTableView endUpdates];
            
            [self CalculateTotal];
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _cellText = cell.textLabel.text;
    
    //UDInvest =  [NSUserDefaults standardUserDefaults];
    
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
    [FundVC setDelegate:self];
    FundVC.preferredContentSize = CGSizeMake(600, 182);
    [FundVC setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:FundVC animated:YES completion:nil];
    FundVC.UDInvest = UDInvest;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setInvestmentDictionary{
    NSMutableArray *arrayInvestList = [[NSMutableArray alloc]init];
    for (int i=0;i<[InvestList count];i++){
        NSMutableDictionary* dictInvestListData = [[NSMutableDictionary alloc]init];
        [dictInvestListData setObject:[_delegate getRunnigSINumber] forKey:@"SINO"];
        [dictInvestListData setObject:@"" forKey:@"FundID"];
        [dictInvestListData setObject:[[InvestList objectAtIndex:i] valueForKey:@"FundName"] forKey:@"FundName"];
        [dictInvestListData setObject:[[InvestList objectAtIndex:i] valueForKey:@"Komposisi"] forKey:@"FundValue"];
        
        
        [arrayInvestList addObject:dictInvestListData];
    }
    [_delegate setInvestmentListDictionary:arrayInvestList];
}

- (IBAction)actionSaveData:(UIButton *)sender {
    //set the updated data to parent
    [self setInvestmentDictionary];
    
    //delete first
    [modelSIFundAllocation deleteFundAllocationData:[_delegate getRunnigSINumber]];
    
    //get updated data from parent and save it.
    NSMutableArray* arrayFundAllocationForInsert = [[NSMutableArray alloc]initWithArray:[_delegate getInvestmentArray]];
    for (int i=0;i<[arrayFundAllocationForInsert count];i++){
        NSMutableDictionary *dictForInsert = [[NSMutableDictionary alloc]initWithDictionary:[arrayFundAllocationForInsert objectAtIndex:i]];
        [dictForInsert setObject:[_delegate getRunnigSINumber] forKey:@"SINO"];
        
        [modelSIFundAllocation saveFundAllocationData:dictForInsert];
    }
    [_delegate showNextPageAfterSave:self];

}
@end
