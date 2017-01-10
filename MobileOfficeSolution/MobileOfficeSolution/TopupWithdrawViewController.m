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
@interface TopupWithdrawViewController (){
    ModelSITopUpWithDraw* modelTopUpWithDraw;
    NSMutableArray* arrayTopUp;
    NSMutableArray* arrayWithDraw;
}

@end

@implementation TopupWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    modelTopUpWithDraw = [[ModelSITopUpWithDraw alloc]init];
    arrayTopUp = [[NSMutableArray alloc]init];
    arrayWithDraw = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)textPenambahanEditingDidEnd:(UITextField *)sender{
    NSDictionary* dictTopUp = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%i",sender.tag],@"Year",sender.text,@"Amount",@"TopUp",@"Option", nil];
    [arrayTopUp addObject:dictTopUp];
}

-(IBAction)textPenarikanEditingDidEnd:(UITextField *)sender{
    NSDictionary* dictTopUp = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%i",sender.tag],@"Year",sender.text,@"Amount",@"WithDraw",@"Option", nil];
    [arrayTopUp addObject:dictTopUp];
}

-(void)setTopUpDictionary{
    NSMutableArray* arrayTopUpWithDraw = [[NSMutableArray alloc]init];
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
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
    
    [cellTopUpWithDraw.lblYear setText:[NSString stringWithFormat:@"%i",indexPath.row+1]];
    [cellTopUpWithDraw.txtPenambahan setText:[NSString stringWithFormat:@"%i",indexPath.row+1]];
    [cellTopUpWithDraw.txtPenarikan setText:[NSString stringWithFormat:@"%i",indexPath.row+1]];
    
    [cellTopUpWithDraw.txtPenambahan addTarget:self action:@selector(textPenambahanEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [cellTopUpWithDraw.txtPenarikan addTarget:self action:@selector(textPenarikanEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
    [cellTopUpWithDraw.txtPenambahan setTag:indexPath.row+1];
    [cellTopUpWithDraw.txtPenarikan setTag:indexPath.row+1];
    
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
