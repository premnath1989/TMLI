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
@synthesize ListOfFrekuensi,ListOfValue,ListOfValueMax,ListOfMOP,ProductCode,CurrencySelected,ListOfValueMaximum1,ListOfValueMaximum2,ListOfRencana;
@synthesize delegate;

-(id)init {
    self = [super init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	
    NSLog(@"productCode = %@",ProductCode);
    
    if([ProductCode isEqualToString:@"3BE"]&&[CurrencySelected isEqualToString:@"Rupiah"])//Investasiku
    {
        ListOfFrekuensi =  [[NSMutableArray alloc] initWithObjects: @"Tahunan",@"Semester",@"Kuartal",@"Bulanan", nil ];
        ListOfValue  =  [[NSMutableArray alloc] initWithObjects:@" 18,000,000", @" 9,000,000",@" 4,500,000",@" 1,500,000", @"" ,nil ];
        ListOfValueMax  =  [[NSMutableArray alloc] initWithObjects:@" 1,000,000", @" 500,000",@" 250,000",@" 100,000", @"" ,nil ];
        ListOfMOP = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"4",@"12", nil];
        ListOfRencana = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];

    }
    else if([ProductCode isEqualToString:@"3FE"]&&[CurrencySelected isEqualToString:@"Rupiah"])//Proteksiku
    {
        ListOfFrekuensi =  [[NSMutableArray alloc] initWithObjects: @"Tahunan",@"Semester",@"Kuartal",@"Bulanan", nil ];
        ListOfValue  =  [[NSMutableArray alloc] initWithObjects:@" 2,400,000", @" 1,200,000",@" 600,000",@" 200,000", @"" ,nil ];
        ListOfValueMax  =  [[NSMutableArray alloc] initWithObjects:@" 1,000,000", @" 500,000",@" 250,000",@" 100,000", @"" ,nil ];
        ListOfMOP = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"4",@"12", nil];
        ListOfRencana = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];

        
    }
    else if([ProductCode isEqualToString:@"3MI"]&&[CurrencySelected isEqualToString:@"Rupiah"])//Mip(IDR)
    {
        ListOfFrekuensi =  [[NSMutableArray alloc] initWithObjects: @"Tahunan",@"Semester",@"Kuartal",@"Bulanan", nil ];
        //Basic_Premi
        ListOfValue  =  [[NSMutableArray alloc] initWithObjects:@" 5,000,000", @" 2,500,000",@" 1,250,000",@" 450,000", @"" ,nil ];
        ListOfValueMaximum1  =  [[NSMutableArray alloc] initWithObjects:@" 499,999,999", @" 249,999,999",@" 124,999,999",@" 44,999,999", @"" ,nil ];
        //Premi_RegularTopUp
        ListOfValueMax  = [[NSMutableArray alloc] initWithObjects:@" 1,000,000", @" 500,000",@" 250,000",@" 100,000", @"" ,nil ];
        ListOfRencana = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
       
        ListOfMOP = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"4",@"12", nil];
        
    }
    else if([ProductCode isEqualToString:@"3MI"]&&[CurrencySelected isEqualToString:@"USD"])//Mip(USD)
    {
       
        ListOfFrekuensi =  [[NSMutableArray alloc] initWithObjects: @"Tahunan",@"Semester",@"Kuartal",@"Bulanan", nil ];
         //Basic_Premi
        ListOfValue  =  [[NSMutableArray alloc] initWithObjects:@" 500", @" 250",@" 125",@" 45", @"" ,nil ];
        ListOfValueMaximum1  =  [[NSMutableArray alloc] initWithObjects:@" 49,999", @" 24,999",@" 12,999",@" 4,500", @"" ,nil ];
        
        //Premi_RegularTopUp
        ListOfValueMax  =  [[NSMutableArray alloc] initWithObjects:@" 100", @" 50",@" 25",@" 10", @"" ,nil ];
        ListOfMOP = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"4",@"12", nil];
        ListOfRencana = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
        
        
    }
    
    else if([ProductCode isEqualToString:@"3MD"]&&[CurrencySelected isEqualToString:@"Rupiah"])//MipPlus(IDR)
    {
        ListOfFrekuensi =  [[NSMutableArray alloc] initWithObjects: @"Tahunan",@"Semester",@"Kuartal",@"Bulanan", nil ];
        //Basic_Premi
        ListOfValue  =  [[NSMutableArray alloc] initWithObjects:@" 500,000,000", @" 250,000,000",@" 125,000,000",@" 45,000,000", @"" ,nil ];
        ListOfValueMaximum1  =  [[NSMutableArray alloc] initWithObjects:@" 499,999,999", @" 249,999,999",@" 124,999,999",@" 44,999,999", @"" ,nil ];
        //Premi_RegularTopUp
        ListOfValueMax  = [[NSMutableArray alloc] initWithObjects:@" 1,000,000", @" 500,000",@" 250,000",@" 100,000", @"" ,nil ];
        
        ListOfMOP = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"4",@"12", nil];
        ListOfRencana = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
        
        
        
        
        
    }
    else if([ProductCode isEqualToString:@"3MD"]&&[CurrencySelected isEqualToString:@"USD"])//MipPlus(USD)
    {
        
        ListOfFrekuensi =  [[NSMutableArray alloc] initWithObjects: @"Tahunan",@"Semester",@"Kuartal",@"Bulanan", nil ];
        //Basic_Premi
        ListOfValue  =  [[NSMutableArray alloc] initWithObjects:@" 50,000", @" 25,000",@" 12,500",@" 4,500", @"" ,nil ];
        ListOfValueMaximum1  =  [[NSMutableArray alloc] initWithObjects:@" 49,999", @" 24,999",@" 12,999",@" 4,500", @"" ,nil ];
        
        //Premi_RegularTopUp
        ListOfValueMax  =  [[NSMutableArray alloc] initWithObjects:@" 100", @" 50",@" 25",@" 10", @"" ,nil ];
        ListOfMOP = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"4",@"12", nil];
        ListOfRencana = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
        
        
    }


    
    else if([ProductCode isEqualToString:@"3RP"]&&[CurrencySelected isEqualToString:@"Rupiah"])//Wealth Accumulation
    {
        ListOfFrekuensi =  [[NSMutableArray alloc] initWithObjects: @"Tahunan",@"Semester",@"Kuartal",@"Bulanan", nil ];
        ListOfValue  =  [[NSMutableArray alloc] initWithObjects:@" 18,000,000", @" 9,000,000",@" 4,500,000",@" 1,500,000", @"" ,nil ];
        ListOfValueMax  =  [[NSMutableArray alloc] initWithObjects:@" 1,000,000", @" 500,000",@" 250,000",@" 100,000", @"" ,nil ];
        ListOfMOP = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"4",@"12", nil];
        ListOfRencana = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
        

               
    }
    else if([ProductCode isEqualToString:@"3SP"]&&[CurrencySelected isEqualToString:@"Rupiah"])//Wealth Enhancement
    {
        
        ListOfFrekuensi =  [[NSMutableArray alloc] initWithObjects: @"Tahunan",@"Semester",@"Kuartal",@"Bulanan", nil ];
        ListOfValue  =  [[NSMutableArray alloc] initWithObjects:@" 18,000,000", @" 9,000,000",@" 4,500,000",@" 1,500,000", @"" ,nil ];
        ListOfValueMax  =  [[NSMutableArray alloc] initWithObjects:@" 1,000,000", @" 500,000",@" 250,000",@" 100,000", @"" ,nil ];
        ListOfMOP = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"4",@"12", nil];
        ListOfRencana = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
        
    }
    else if([ProductCode isEqualToString:@"1TE"]&&[CurrencySelected isEqualToString:@"Rupiah"])// Peace of Mind
    {
        
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
  
    [delegate Frekuensilisting:self didSelectCode:self.selectedDesc :self.selectedValue :self.selectedValueMax :self.selectedMOP:self.selectedRencana];
    
   
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

-(NSString *)selectedRencana
{
    return [ListOfRencana objectAtIndex:selectedIndex];
}


- (void)viewDidUnload
{
    [self setDelegate:nil];
    [super viewDidUnload];
}

@end
