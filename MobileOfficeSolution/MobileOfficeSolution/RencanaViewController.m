//
//  RencanaViewController.m
//  MobileOfficeSolution
//
//  Created by Premnath on 14/11/2016.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import "RencanaViewController.h"

@interface RencanaViewController ()

@end

@implementation RencanaViewController
@synthesize ListOfRencana,rencanaType;
@synthesize delegate;

-(id)init {
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ListOfRencana = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ListOfRencana count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [ListOfRencana objectAtIndex:indexPath.row];
    
    if (indexPath.row == selectedIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16 ];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [delegate Rencanalisting:self didSelectCode:self.selectedDesc];
    
    [tableView reloadData];
}


-(NSString *)selectedDesc
{
    return [ListOfRencana objectAtIndex:selectedIndex];
}

- (void)viewDidUnload
{
    [self setDelegate:nil];
    [super viewDidUnload];
}

@end
