//
//  PlanList.m
//  HLA Ipad
//
//  Created by shawal sapuan on 10/16/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MasaPembayaran.h"

@interface MasaPembayaran ()

@end

@implementation MasaPembayaran
@synthesize ListOfPlan,ListOfCode,selectedCode,selectedDesc, TradOrEver,ListofMaxAgeLA,ListofMinAgeLA,ListofMaxAgePO,ListofMinAgePO;
@synthesize delegate;

-(id)init {
    self = [super init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
		ListOfPlan = [[NSMutableArray alloc] initWithObjects:@"Secure100", @"HLA Wealth Plan", nil ];
		ListOfCode = [[NSMutableArray alloc] initWithObjects:@"S100", @"HLAWP", nil ];
        ListOfPlan = [[NSMutableArray alloc] initWithObjects:@"TM Link Investasiku",@"TM Link ProteksiKu",@"TM Maximum Investment Plan(MIP)",@"TM Maximum Investment Plan(MIP Plus)",@"TM Link Wealth Accumulation",@"TM Link Wealth Enhancement",nil];
        ListOfCode = [[NSMutableArray alloc] initWithObjects:@"3BE",@"3FE",@"3MI",@"3MD",@"3RP",@"3SP",@"3SP",@"1TE", nil ];
        ListofMinAgePO = [[NSMutableArray alloc] initWithObjects:@"18",@"18",@"15",@"15",@"18",@"18",nil ];
        ListofMaxAgePO = [[NSMutableArray alloc] initWithObjects:@"70",@"70",@"70",@"70",@"70",@"70",nil ];
        ListofMinAgeLA = [[NSMutableArray alloc] initWithObjects:@"15",@"15",@"15",@"15",@"15",@"15",nil ];
        ListofMaxAgeLA = [[NSMutableArray alloc] initWithObjects:@"70",@"70",@"70",@"70",@"70",@"70",nil ];
//		ListOfPlan = [[NSMutableArray alloc] initWithObjects:@"HLA Wealth Plan", nil ];
//		ListOfCode = [[NSMutableArray alloc] initWithObjects:@"HLAWP", nil ];
        
        //ListOfPlan = [[NSMutableArray alloc] initWithObjects:@"Life100", nil ];
        //ListOfCode = [[NSMutableArray alloc] initWithObjects:@"L100", nil ];
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
    return [ListOfPlan count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
	cell.textLabel.text = [ListOfPlan objectAtIndex:indexPath.row];
    
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
    
    NSString *testing = TradOrEver;
    
    int number = [testing intValue];
    
    
    
    
   // Relationship
    
//    && ([self.selectedDesc isEqualToString:@"TM Maximum Investment Plan(MIP)"]) || [self.selectedDesc isEqualToString:@"TM Maximum Investment PlanPlan(MIP Plus)"])
    
    if ([_Relationship isEqualToString:@"DIRI SENDIRI"] && ([testing intValue] > 70 || [testing intValue] < 15) && ([self.selectedDesc isEqualToString:@"TM Maximum Investment Plan(MIP)"] || [self.selectedDesc isEqualToString:@"TM Maximum Investment Plan(MIP Plus)"]) )
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Usia Pemegang Polis : Min : 15  Max : 70 " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag=12000;
        [alert show];
  
    }
    else if ([_Relationship isEqualToString:@"DIRI SENDIRI"] && ([testing intValue] > 70 || [testing intValue] < 18))
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Usia Pemegang Polis : Min : 18  Max : 70 " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag=12000;
        [alert show];

    }
    else if ([_Relationship isEqualToString:@""] && ([testing intValue] > 70 || [testing intValue] < 15))
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Usia Tertanggung : Min : 18  Max : 70 " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag=12000;
        [alert show];
    }
    else

    {
        [delegate Planlisting:self didSelectCode:self.selectedCode andDesc:self.selectedDesc :self.selectedMaxAgePO :self.selectedMinAgePO :self.selectedMaxAgeLA :self.selectedMinAgeLA];

    }
    

    
    
    [tableView reloadData];
}

-(NSString *)selectedCode
{
    return [ListOfCode objectAtIndex:selectedIndex];
}

-(NSString *)selectedDesc
{
    
    
    return [ListOfPlan objectAtIndex:selectedIndex];
}

-(NSString *)selectedMaxAgePO
{
    return [ListofMaxAgePO objectAtIndex:selectedIndex];
}

-(NSString *)selectedMinAgePO
{
    return [ListofMinAgePO objectAtIndex:selectedIndex];
}

-(NSString *)selectedMaxAgeLA
{
    return [ListofMaxAgeLA objectAtIndex:selectedIndex];
}

-(NSString *)selectedMinAgeLA
{
    return [ListofMinAgeLA objectAtIndex:selectedIndex];
}


- (void)viewDidUnload
{
    [self setDelegate:nil];
    [super viewDidUnload];
}

@end
