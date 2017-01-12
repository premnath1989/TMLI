//
//  TopupWithdrawViewController.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/9/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "TopupWithdrawViewController.h"
#import "TopUpWithDrawTableViewCell.h"
#import "ModelSITopUpWithDraw.h"
#import "Formatter.h"

@interface TopupWithdrawViewController ()<UITextFieldDelegate>{
    Formatter* formatter;
    ModelSITopUpWithDraw* modelTopUpWithDraw;
    NSMutableArray* arrayTopUpWithDraw;
    NSMutableArray* arrayTopUp;
    NSMutableArray* arrayWithDraw;
}

@end

@implementation TopupWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    formatter = [[Formatter alloc]init];
    modelTopUpWithDraw = [[ModelSITopUpWithDraw alloc]init];
    arrayTopUp = [[NSMutableArray alloc]init];
    arrayWithDraw = [[NSMutableArray alloc]init];
    
    arrayTopUpWithDraw = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataFromList{
    arrayTopUpWithDraw = [[NSMutableArray alloc]initWithArray:[_delegate getTopUpWithDrawArray]];
    if ([arrayTopUpWithDraw count]<=0){
    }
    else{
        arrayTopUp = [[NSMutableArray alloc]init];
        arrayWithDraw = [[NSMutableArray alloc]init];
        arrayTopUp = [[arrayTopUpWithDraw filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(Option == %@)", @"TopUp"]] mutableCopy];
        arrayWithDraw = [[arrayTopUpWithDraw filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(Option == %@)", @"WithDraw"]] mutableCopy];
        //[self refreshRiderData];
        [tableTopUpWithDraw reloadData];
    }
}

-(void)RealTimeFormat:(UITextField *)sender{
    NSNumber *plainNumber = [formatter convertAnyNonDecimalNumberToString:sender.text];
    [sender setText:[formatter numberToCurrencyDecimalFormatted:plainNumber]];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    //    if ((textField == textTopUpAmount)||(textField == textWithDrawalAmount))
    //    {
    BOOL return13digit = FALSE;
    //KY - IMPORTANT - PUT THIS LINE TO DETECT THE FIRST CHARACTER PRESSED....
    //This method is being called before the content of textField.text is changed.
    NSString * AI = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([AI rangeOfString:@"."].length == 1) {
        NSArray  *comp = [AI componentsSeparatedByString:@"."];
        NSString *get_num = [[comp objectAtIndex:0] stringByReplacingOccurrencesOfString:@"," withString:@""];
        int c = [get_num length];
        return13digit = (c > 15);
        
    } else if([AI rangeOfString:@"."].length == 0) {
        NSArray  *comp = [AI componentsSeparatedByString:@"."];
        NSString *get_num = [[comp objectAtIndex:0] stringByReplacingOccurrencesOfString:@"," withString:@""];
        int c = [get_num length];
        return13digit = (c  > 15);
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if( return13digit == TRUE) {
        return (([string isEqualToString:filtered])&&(newLength <= 15));
    } else {
        return (([string isEqualToString:filtered])&&(newLength <= 19));
    }
    //    }
    return YES;
}



-(IBAction)textPenambahanEditingDidEnd:(UITextField *)sender{
    NSDictionary* dictTopUp = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%i",sender.tag],@"Year",sender.text,@"Amount",@"TopUp",@"Option", nil];
    if ([[arrayTopUp valueForKey:@"Year"] containsObject:[NSString stringWithFormat:@"%i",sender.tag]]){
        int index = [[arrayTopUp valueForKey:@"Year"] indexOfObject:[NSString stringWithFormat:@"%i",sender.tag]];
        [arrayTopUp replaceObjectAtIndex:index withObject:dictTopUp];
    }
    else{
        [arrayTopUp addObject:dictTopUp];
    }
    
}

-(IBAction)textPenarikanEditingDidEnd:(UITextField *)sender{
    NSDictionary* dictWithDraw = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%i",sender.tag],@"Year",sender.text,@"Amount",@"WithDraw",@"Option", nil];
    if ([[arrayWithDraw valueForKey:@"Year"] containsObject:[NSString stringWithFormat:@"%i",sender.tag]]){
        int index = [[arrayWithDraw valueForKey:@"Year"] indexOfObject:[NSString stringWithFormat:@"%i",sender.tag]];
        [arrayWithDraw replaceObjectAtIndex:index withObject:dictWithDraw];
    }
    else{
        [arrayWithDraw addObject:dictWithDraw];
    }
}

-(void)setTopUpDictionary{
    arrayTopUpWithDraw = [[NSMutableArray alloc]init];
    for (int i=0; i<[arrayTopUp count];i++){
        [arrayTopUpWithDraw addObject:[arrayTopUp objectAtIndex:i]];
    }
    
    for (int x=0; x<[arrayWithDraw count];x++){
        [arrayTopUpWithDraw addObject:[arrayWithDraw objectAtIndex:x]];
    }
    
    [_delegate setTopUpWithDrawDictionary:arrayTopUpWithDraw];
}

#pragma mark saveData
-(IBAction)actionSaveData:(UIButton *)sender{
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    //set the updated data to parent
    [self setTopUpDictionary];
    
    //delete first
    [modelTopUpWithDraw deleteTopUpWithDrawData:[_delegate getRunnigSINumber]];
    
    //get updated data from parent and save it.
    NSMutableArray* arrayTopUpWithDrawForInsert = [[NSMutableArray alloc]initWithArray:[_delegate getTopUpWithDrawArray]];
    for (int i=0;i<[arrayTopUpWithDrawForInsert count];i++){
        NSMutableDictionary *dictForInsert = [[NSMutableDictionary alloc]initWithDictionary:[arrayTopUpWithDrawForInsert objectAtIndex:i]];
        [dictForInsert setObject:[_delegate getRunnigSINumber] forKey:@"SINO"];
        
        [modelTopUpWithDraw saveTopUpWithDrawData:dictForInsert];
    }
}

-(NSString *)getTextPenambahanForTableView:(NSString *)stringRow{
    NSString *stringPenambahan = @"";
    for (int i=0; i<[arrayTopUp count];i++){
        if ([stringRow isEqualToString:[[arrayTopUp objectAtIndex:i] valueForKey:@"Year"]]){
            stringPenambahan = [[arrayTopUp objectAtIndex:i] valueForKey:@"Amount"];
            return stringPenambahan;
        }
    }
    return stringPenambahan;
}

-(NSString *)getTextPenarikanForTableView:(NSString *)stringRow{
    NSString *stringPenarikan = @"";
    for (int i=0; i<[arrayWithDraw count];i++){
        if ([stringRow isEqualToString:[[arrayWithDraw objectAtIndex:i] valueForKey:@"Year"]]){
            stringPenarikan = [[arrayWithDraw objectAtIndex:i] valueForKey:@"Amount"];
            return stringPenarikan;
        }
    }
    return stringPenarikan;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section
{
    return 99;
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
    static NSString *CellIdentifier = @"Cell";
    TopUpWithDrawTableViewCell *cellTopUpWithDraw = (TopUpWithDrawTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UIView* selectedView = [[UIView alloc] initWithFrame:cellTopUpWithDraw.frame];
    [selectedView setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:117.0/255.0 blue:134.0/255.0 alpha:1.0]];

    if (cellTopUpWithDraw == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TopUpWithDrawTableViewCell" owner:self options:nil];
        cellTopUpWithDraw = [nib objectAtIndex:0];
    }
    [cellTopUpWithDraw.txtPenambahan setDelegate:self];
    [cellTopUpWithDraw.txtPenarikan setDelegate:self];

    
    
    [cellTopUpWithDraw.lblYear setText:[NSString stringWithFormat:@"%i",indexPath.row+1]];
    [cellTopUpWithDraw.txtPenambahan setText:[self getTextPenambahanForTableView:cellTopUpWithDraw.lblYear.text]];
    [cellTopUpWithDraw.txtPenarikan setText:[self getTextPenarikanForTableView:cellTopUpWithDraw.lblYear.text]];
    
    [cellTopUpWithDraw.txtPenambahan addTarget:self action:@selector(RealTimeFormat:) forControlEvents:UIControlEventEditingChanged];
    [cellTopUpWithDraw.txtPenarikan addTarget:self action:@selector(RealTimeFormat:) forControlEvents:UIControlEventEditingChanged];
    
    [cellTopUpWithDraw.txtPenambahan addTarget:self action:@selector(textPenambahanEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [cellTopUpWithDraw.txtPenarikan addTarget:self action:@selector(textPenarikanEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
    [cellTopUpWithDraw.txtPenambahan setTag:indexPath.row+1];
    [cellTopUpWithDraw.txtPenarikan setTag:indexPath.row+1];
    
    
    
    /*if (indexPath.row < [arrayTopUpWithDraw count]){
        if ([[[arrayTopUpWithDraw objectAtIndex:indexPath.row] valueForKey:@"Option"]isEqualToString:@"TopUp"]){
            if ([[[arrayTopUpWithDraw objectAtIndex:indexPath.row] valueForKey:@"Year"]isEqualToString:[NSString stringWithFormat:@"%i",indexPath.row+1]]){
                [cellTopUpWithDraw.txtPenambahan setText:[[arrayTopUpWithDraw objectAtIndex:indexPath.row] valueForKey:@"Amount"]];
            }
        }
        else if ([[[arrayTopUpWithDraw objectAtIndex:indexPath.row] valueForKey:@"Option"]isEqualToString:@"WithDraw"]){
            if ([[[arrayTopUpWithDraw objectAtIndex:indexPath.row] valueForKey:@"Year"]isEqualToString:[NSString stringWithFormat:@"%i",indexPath.row+1]]){
                [cellTopUpWithDraw.txtPenambahan setText:[[arrayTopUpWithDraw objectAtIndex:indexPath.row] valueForKey:@"Amount"]];
            }
        }
    }
    else{
        [cellTopUpWithDraw.txtPenambahan setText:@""];
        [cellTopUpWithDraw.txtPenarikan setText:@""];
    }*/
    
    [cellTopUpWithDraw setSelectedBackgroundView:selectedView];
    if ((indexPath.row % 2) == 0){
        [cellTopUpWithDraw setBackgroundColor:[UIColor whiteColor]];
    }
    else{
        [cellTopUpWithDraw setBackgroundColor:[UIColor colorWithRed:231.0/255.0 green:233.0/255.0 blue:234.0/255.0 alpha:1.0]];
    }
    
    
    return cellTopUpWithDraw;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
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
