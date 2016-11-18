//
//  PzyorWaiverViewController.m
//  MobileOfficeSolution
//
//  Created by Premnath on 18/11/2016.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import "PzyorWaiverViewController.h"

@interface PzyorWaiverViewController ()

@end

@implementation PzyorWaiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    NSMutableArray* RiderListTMLI1 =[NSMutableArray arrayWithObjects:@"10A",@"10B",@"10C",@"55A",@"55B",@"65A",@"65B",nil];
    
    
    cell.textLabel.text =  [RiderListTMLI1 objectAtIndex:indexPath.row];
    

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

- (IBAction)CancelSubview:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
