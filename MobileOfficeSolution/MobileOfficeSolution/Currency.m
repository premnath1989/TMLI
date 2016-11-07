//
//  Currency.m
//  HLA Ipad
//
//  Created by Premnath on 10/16/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Currency.h"

@interface Currency ()

@end

@implementation Currency
@synthesize ListOfCurrency,CurrencyType;
@synthesize delegate;

-(id)init {
    self = [super init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([CurrencyType isEqualToString:@"3BE"])//Investasiku
    {
        ListOfCurrency = [[NSMutableArray alloc] initWithObjects:@"Rupiah", nil ];
    }
    else if([CurrencyType isEqualToString:@"3FE"])//Proteksiku
    {
        
       ListOfCurrency = [[NSMutableArray alloc] initWithObjects:@"Rupiah", nil ];
    }
    else if([CurrencyType isEqualToString:@"3MI"])//Mip
    {
        ListOfCurrency = [[NSMutableArray alloc] initWithObjects:@"Rupiah", @"USD", nil ];
        
    }
    else if([CurrencyType isEqualToString:@"3MD"])//Mip
    {
        ListOfCurrency = [[NSMutableArray alloc] initWithObjects:@"Rupiah", @"USD", nil ];
        
    }

    else if([CurrencyType isEqualToString:@"3RP"])//Wealth Accumulation
    {
        ListOfCurrency = [[NSMutableArray alloc] initWithObjects:@"Rupiah", nil ];
        
    }
    else if([CurrencyType isEqualToString:@"3SP"])//Wealth Enhancement
    {
       ListOfCurrency = [[NSMutableArray alloc] initWithObjects:@"Rupiah", nil ];
        
    }
    else if([CurrencyType isEqualToString:@"1TE"])// Peace of Mind
    {
        ListOfCurrency = [[NSMutableArray alloc] initWithObjects:@"Rupiah", nil ];
    }
    


	
    

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
    return [ListOfCurrency count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
	cell.textLabel.text = [ListOfCurrency objectAtIndex:indexPath.row];
    
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
    [delegate Currencylisting:self didSelectCode:self.selectedDesc];
    
    [tableView reloadData];
}


-(NSString *)selectedDesc
{
    return [ListOfCurrency objectAtIndex:selectedIndex];
}

- (void)viewDidUnload
{
    [self setDelegate:nil];
    [super viewDidUnload];
}

@end
