//
//  RiderViewController.m
//  HLA
//
//  Created by shawal sapuan on 8/1/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "RiderViewController.h"
#import "BasicPlanViewController.h"
#import "NewLAViewController.h"
#import "ColorHexCode.h"
#import "AppDelegate.h"
#import "MainScreen.h"
#import "PremiumViewController.h"
#import "Constants.h"
#import "UIView+viewRecursion.h"
#import "LoginDBManagement.h"
#import "RiderValueTableViewCell.h"
#import "Model_SI_Rider.h"

@interface RiderViewController (){
    Model_SI_Rider *model_SI_Rider;
    
    NSMutableArray* arrayRiderData;
    
    NSMutableArray* arrayRiderType;
    NSMutableArray* arrayRiderName;
    NSMutableArray* arrayRiderNameDetail;
    NSMutableArray* arrayRiderValueDetail;
    
    NSMutableDictionary* dictRiderName;
}

@end
BOOL Edit = FALSE;
int RiderPopoverCount;

@implementation RiderViewController


#pragma mark - Cycle View

int maxGycc = 0;

- (void)viewDidLoad
{
    
    riderCalculation = [[RiderCalculation alloc]init];
    CustomColor = [[ColorHexCode alloc]init];
    formatter = [[Formatter alloc]init];
    _modelSIRider = [[ModelSIRider alloc]init];
    model_SI_Rider = [[Model_SI_Rider alloc]init];
    
    riderValueInputVC = [[RiderValueInputViewController alloc]initWithNibName:@"RiderValueInputViewController" bundle:nil];
    [riderValueInputVC setDelegate:self];
    
    arrayRiderType = [[NSMutableArray alloc]initWithArray:[self getArrayType]];
    arrayRiderName = [[NSMutableArray alloc]init];
    arrayRiderNameDetail = [[NSMutableArray alloc]init];
    arrayRiderValueDetail = [[NSMutableArray alloc]init];

    [self setDictionaryRiderName];
    [super viewDidLoad];
}

-(void)loadDataFromList{
    arrayRiderData=[[NSMutableArray alloc]init];
    arrayRiderData = [_delegate getRiderArray];
    [self setRiderDetailFromDelegate:arrayRiderData];
    
    if ([arrayRiderData count]<=0){
    }
    else{
        [self refreshRiderData];
        [tableRiderDetail reloadData];
    }
    //[self clearRiderDataDetail];
}

-(NSMutableArray *)getArrayType{
    NSMutableArray* arrRiderType = [[NSMutableArray alloc]initWithObjects:@"Rider Type 1",@"Rider Type 2",@"Rider Type 3",@"Rider Type 4",@"Rider Type 5", nil];
    return arrRiderType;
}

-(void)setDictionaryRiderName{
    dictRiderName = [[NSMutableDictionary alloc]init];
    
    NSMutableArray* arrRiderNameType1 = [[NSMutableArray alloc]initWithObjects:@"Rider Name 1 Type 1",@"Rider Name 2 Type 1",@"Rider Name 3 Type 1", nil];
    NSMutableArray* arrRiderNameType2 = [[NSMutableArray alloc]initWithObjects:@"Rider Name 1 Type 2",@"Rider Name 2 Type 2",@"Rider Name 3 Type 2", nil];
    NSMutableArray* arrRiderNameType3 = [[NSMutableArray alloc]initWithObjects:@"Rider Name 1 Type 3",@"Rider Name 2 Type 3",@"Rider Name 3 Type 3", nil];
    NSMutableArray* arrRiderNameType4 = [[NSMutableArray alloc]initWithObjects:@"Rider Name 1 Type 4",@"Rider Name 2 Type 4",@"Rider Name 3 Type 4", nil];
    NSMutableArray* arrRiderNameType5 = [[NSMutableArray alloc]initWithObjects:@"Rider Name 1 Type 5",@"Rider Name 2 Type 5",@"Rider Name 3 Type 5", nil];
    
    [dictRiderName setObject:arrRiderNameType1 forKey:@"Rider Type 1"];
    [dictRiderName setObject:arrRiderNameType2 forKey:@"Rider Type 2"];
    [dictRiderName setObject:arrRiderNameType3 forKey:@"Rider Type 3"];
    [dictRiderName setObject:arrRiderNameType4 forKey:@"Rider Type 4"];
    [dictRiderName setObject:arrRiderNameType5 forKey:@"Rider Type 5"];
}

-(void)setRiderDetailFromDelegate:(NSMutableArray *)arrayRider{
    for (int i=0;i<[arrayRider count];i++){
        [arrayRiderNameDetail addObject:[[arrayRider objectAtIndex:i]valueForKey:@"RiderDesc"]];
        [arrayRiderValueDetail addObject:[[arrayRider objectAtIndex:i]valueForKey:@"SumAssured"]];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillAppear:(BOOL)animated
{    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}


- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark - keyboard display

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
	
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    
}

-(void)textFieldDidChange:(UITextField*)textField
{

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

-(void)riderTypeSelected:(NSIndexPath *)indexPath{
    arrayRiderName = [[NSMutableArray alloc]initWithArray:[dictRiderName valueForKey:[arrayRiderType objectAtIndex:indexPath.row]]];
    [tableRiderName reloadData];
}

-(void)actionRiderValueInput:(NSString *)stringRiderName StringRiderValue:(NSString *)stringRiderValue{
    
    riderValueInputVC.preferredContentSize = CGSizeMake(600, 182);
    [riderValueInputVC setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:riderValueInputVC animated:YES completion:nil];
    [riderValueInputVC setRiderDetailInformation:stringRiderName StringRiderValue:stringRiderValue];
}

#pragma mark delegate rider input value
-(void)saveRiderInput:(NSString *)stringRiderName RiderValue:(NSString *)stringRiderValue{
    [arrayRiderNameDetail addObject:stringRiderName];
    [arrayRiderValueDetail addObject:stringRiderValue];
    
    [tableRiderDetail reloadData];
}

-(void)setRiderDictionary{
    arrayRiderData = [[NSMutableArray alloc]init];
    for (int i=0;i<[arrayRiderNameDetail count];i++){
        NSMutableDictionary* dictRiderData = [[NSMutableDictionary alloc]init];
        [dictRiderData setObject:[_delegate getRunnigSINumber] forKey:@"SINO"];
        [dictRiderData setObject:@"" forKey:@"RiderCode"];
        [dictRiderData setObject:[arrayRiderNameDetail objectAtIndex:i] forKey:@"RiderDesc"];
        [dictRiderData setObject:[arrayRiderValueDetail objectAtIndex:i] forKey:@"SumAssured"];
        [dictRiderData setObject:@"" forKey:@"Term"];
        [dictRiderData setObject:@"" forKey:@"ExtraPremiMil"];
        [dictRiderData setObject:@"" forKey:@"ExtraPremiMilTerm"];
        [dictRiderData setObject:@"" forKey:@"ExtraPremiPercent"];
        [dictRiderData setObject:@"" forKey:@"ExtraPremiPercentTerm"];
        
        [arrayRiderData addObject:dictRiderData];
    }
    [_delegate setRiderDictionary:arrayRiderData];
}

-(void)refreshRiderData{
    //set the updated data to parent
    [self setRiderDictionary];
    
    //delete first
    [model_SI_Rider deleteRiderData:[_delegate getRunnigSINumber]];
    
    //get updated data from parent and save it.
    NSMutableArray* arrayRiderForInsert = [[NSMutableArray alloc]initWithArray:[_delegate getRiderArray]];
    for (int i=0;i<[arrayRiderForInsert count];i++){
        NSMutableDictionary *dictForInsert = [[NSMutableDictionary alloc]initWithDictionary:[arrayRiderForInsert objectAtIndex:i]];
        [dictForInsert setObject:[_delegate getRunnigSINumber] forKey:@"SINO"];
        
        [model_SI_Rider saveRiderData:dictForInsert];
    }
    
}

-(IBAction)actionSaveData:(UIButton *)sender{
    //set the updated data to parent
    [self setRiderDictionary];
    
    //delete first
    [model_SI_Rider deleteRiderData:[_delegate getRunnigSINumber]];
    
    //get updated data from parent and save it.
    NSMutableArray* arrayRiderForInsert = [[NSMutableArray alloc]initWithArray:[_delegate getRiderArray]];
    for (int i=0;i<[arrayRiderForInsert count];i++){
        NSMutableDictionary *dictForInsert = [[NSMutableDictionary alloc]initWithDictionary:[arrayRiderForInsert objectAtIndex:i]];
        [dictForInsert setObject:[_delegate getRunnigSINumber] forKey:@"SINO"];
        
        [model_SI_Rider saveRiderData:dictForInsert];
    }
    [_delegate showNextPageAfterSave:self];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section
{
    if (myTableView == tableRiderType){
        return [arrayRiderType count];
    }
    else if (myTableView == tableRiderName){
        return [arrayRiderName count];
    }
    else if (myTableView == tableRiderDetail){
        return [arrayRiderNameDetail count];
    }
    
    return 0;
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
    
    if (tableView == tableRiderType){
        [cell.textLabel setText:[arrayRiderType objectAtIndex:indexPath.row]];
    }
    
    else if (tableView == tableRiderName){
        [cell.textLabel setText:[arrayRiderName objectAtIndex:indexPath.row]];
    }
    
    else if (tableView == tableRiderDetail){
        static NSString *CellIdentifier = @"Cell";
        RiderValueTableViewCell *cellRider = (RiderValueTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cellRider == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RiderValueTableViewCell" owner:self options:nil];
            cellRider = [nib objectAtIndex:0];
        }
        
        [cellRider.labelRiderName setText:[arrayRiderNameDetail objectAtIndex:indexPath.row]];
        [cellRider.labelRiderValue setText:[arrayRiderValueDetail objectAtIndex:indexPath.row]];
        [cellRider setSelectedBackgroundView:selectedView];
        if ((indexPath.row % 2) == 0){
            [cellRider setBackgroundColor:[UIColor whiteColor]];
        }
        else{
            [cellRider setBackgroundColor:[UIColor colorWithRed:231.0/255.0 green:233.0/255.0 blue:234.0/255.0 alpha:1.0]];
        }
        return cellRider;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (tableView == tableRiderType){
        [self riderTypeSelected:indexPath];
    }
    else if (tableView == tableRiderName){
        [self actionRiderValueInput:[arrayRiderName objectAtIndex:indexPath.row] StringRiderValue:@""];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    if (tableView == tableRiderType){
        return NO;
    }
    else if (tableView == tableRiderName){
        return NO;
    }
    else if (tableView == tableRiderDetail){
        return YES;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tableRiderDetail){
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [arrayRiderNameDetail removeObjectAtIndex:indexPath.row];
            [arrayRiderValueDetail removeObjectAtIndex:indexPath.row];
            
            [tableRiderDetail beginUpdates];
            [tableRiderDetail deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableRiderDetail endUpdates];
        }
    }
}
#
- (void)viewDidUnload
{
    [self resignFirstResponder];
    [super viewDidUnload];
}



@end
