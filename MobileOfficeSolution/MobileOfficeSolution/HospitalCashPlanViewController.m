//
//  HospitalCashPlanViewController.m
//  MobileOfficeSolution
//
//  Created by Premnath on 11/11/2016.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import "HospitalCashPlanViewController.h"

@interface HospitalCashPlanViewController ()

@end

@implementation HospitalCashPlanViewController
@synthesize TableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _RiderListTMLI =[NSMutableArray arrayWithObjects:@"Waiver Premium",@"Payor Benefit",@"AD&ADD",@"Hospitalization & Surgical",@"Hospital Cash Plan",@"Term Life",@"CI 55 (CI additional)", nil];
    
    [TableView reloadData];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return 0;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
        cell.textLabel.text = [_RiderListTMLI objectAtIndex:indexPath.row];
    
    
    
    return cell;
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //UITableViewCell *currentCell = [myTableView cellForRowAtIndexPath:indexPath];
    //currentCell.frame = CGRectMake(currentCell.frame.origin.x, currentCell.frame.origin.y, 750, currentCell.frame.size.height);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    
    
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
