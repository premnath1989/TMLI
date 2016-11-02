//
//  FrekuensiTwo.m
//  HLA Ipad
//
//  Created by Premnath on 10/16/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "FrekuensiTwo.h"

@interface FrekuensiTwo ()

@end

@implementation FrekuensiTwo
@synthesize ListOfFrekuensi,ListOfValue,ListOfValueMax,ListOfMOP;
@synthesize delegate;

-(id)init {
    self = [super init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	
    ListOfFrekuensi =  [[NSMutableArray alloc] initWithObjects: @"Tahunan",@"Semester",@"Kuartal",@"Bulanan", nil ];
    ListOfValue  =  [[NSMutableArray alloc] initWithObjects:@"IDR 18,000,000", @"IDR 9,000,000",@"IDR 4,500,000",@"IDR 1,500,000", @"" ,nil ];
    ListOfValueMax  =  [[NSMutableArray alloc] initWithObjects:@"IDR 1,000,000", @"IDR 500,000",@"IDR 250,000",@"IDR 100,000", @"" ,nil ];
    ListOfMOP = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"4",@"12", nil];
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
    return [ListOfFrekuensi count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
	cell.textLabel.text = [ListOfFrekuensi objectAtIndex:indexPath.row];
    
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
  
    [delegate Frekuensilisting:self didSelectCode:self.selectedDesc :self.selectedValue :self.selectedValueMax :self.selectedMOP];
   
    [tableView reloadData];
}


-(NSString *)selectedDesc
{
    return [ListOfFrekuensi objectAtIndex:selectedIndex];
}

-(NSString *)selectedValue
{
    return [ListOfValue objectAtIndex:selectedIndex];
}

-(NSString *)selectedValueMax
{
    return [ListOfValueMax objectAtIndex:selectedIndex];
}

-(NSString *)selectedMOP
{
    return [ListOfMOP objectAtIndex:selectedIndex];
}

- (void)viewDidUnload
{
    [self setDelegate:nil];
    [super viewDidUnload];
}

@end
