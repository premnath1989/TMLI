//
//  ProductRecommended.m
//  MPOS
//
//  Created by Meng Cheong on 8/26/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ProductRecommended.h"
#import "DataClass.h"
#import "ExistingProductRecommended.h"
#import "textFields.h"

@interface ProductRecommended (){
    DataClass *obj;
}

@end

@implementation ProductRecommended
@synthesize ExistingProductRecommendedVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"CFF_1" bundle:nil];
    
    if([_cellRghtbuttonDisabled isEqualToString:@"disable"])
    {
       [_rightbutton setEnabled:NO]; 
    }
    
    BOOL doesContain = [self.myView.subviews containsObject:self.ExistingProductRecommendedVC.view];
    if (!doesContain){
        self.ExistingProductRecommendedVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ExistingProductRecommended"];
        self.ExistingProductRecommendedVC.rowToUpdate = self.rowToUpdate;
        [self addChildViewController:self.ExistingProductRecommendedVC];
        ExistingProductRecommendedVC.view.frame = CGRectMake(-10,
                                                             self.ExistingProductRecommendedVC.view.frame.origin.y,
                                                             self.ExistingProductRecommendedVC.view.frame.size.width,
                                                             self.ExistingProductRecommendedVC.view.frame.size.height);
        [self.myView addSubview:self.ExistingProductRecommendedVC.view];
       
        
       // [_rightbutton setEnabled:YES];
    }

       
    

    obj=[DataClass getInstance];
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMyView:nil];
    [self setRightbutton:nil];
    [super viewDidUnload];
}

//fixed bug 2612 start
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000){
        [self.ExistingProductRecommendedVC.NameOfInsured becomeFirstResponder];
    }
    else if (alertView.tag == 1001){
        [self.ExistingProductRecommendedVC.ProductType becomeFirstResponder];
    }
    else if (alertView.tag == 1002){
        [self.ExistingProductRecommendedVC.Term becomeFirstResponder];
    }
    else if (alertView.tag == 1003){
        [self.ExistingProductRecommendedVC.Premium becomeFirstResponder];
    }
    else if (alertView.tag == 1004){
        [self.ExistingProductRecommendedVC.SumAssured becomeFirstResponder];
    }
}
//fixed bug 2612 end

- (IBAction)doSave:(id)sender {
    [self hideKeyboard];
	//fixed bug 2612 start
    if([textFields trimWhiteSpaces:self.ExistingProductRecommendedVC.NameOfInsured.text].length == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Name of Insured is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1000;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([textFields validateString:self.ExistingProductRecommendedVC.NameOfInsured.text]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Invalid name format. Same alphabet cannot be repeated more than 3 times."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1000;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([textFields validateString3:self.ExistingProductRecommendedVC.NameOfInsured.text]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Invalid Name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1000;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([textFields trimWhiteSpaces:self.ExistingProductRecommendedVC.ProductType.text].length == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Product Type is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1001;
        [alert show];
        alert = Nil;
        return;
    }
	else if ([textFields trimWhiteSpaces:self.ExistingProductRecommendedVC.Term.text].length == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Term is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1002;
        [alert show];
        alert = Nil;
        return;
    }
	else if ([textFields trimWhiteSpaces:self.ExistingProductRecommendedVC.Premium.text].length == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Premium is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1003;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([self.ExistingProductRecommendedVC.Premium.text isEqualToString:@"0.00"] || [self.ExistingProductRecommendedVC.Premium.text isEqualToString:@".00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Premium must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1003;
        [alert show];
        alert = Nil;
        return;
    }
	else if (self.ExistingProductRecommendedVC.Frequency.selectedSegmentIndex == -1){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Frequency is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return;
    }
	else if ([textFields trimWhiteSpaces:self.ExistingProductRecommendedVC.SumAssured.text].length == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Sum Assured is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1004;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([self.ExistingProductRecommendedVC.SumAssured.text isEqualToString:@"0.00"] || [self.ExistingProductRecommendedVC.SumAssured.text isEqualToString:@".00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Sum Assured must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1004;
        [alert show];
        alert = Nil;
        return;
    }
	else if (!([self.ExistingProductRecommendedVC.click isEqualToString:@"Yes"])) {
		
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Bought Option is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return;
    }
	//fixed bug 2612 end
	if (self.rowToUpdate == 0) {
        
    }
    else if (self.rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.NameOfInsured.text forKey:@"NameOfInsured1"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.ProductType.text forKey:@"ProductType1"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.Term.text forKey:@"Term1"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.Premium.text forKey:@"Premium1"];
        if (self.ExistingProductRecommendedVC.Frequency.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecI"] setValue:[self getFrequencyCode:[self.ExistingProductRecommendedVC.Frequency titleForSegmentAtIndex:self.ExistingProductRecommendedVC.Frequency.selectedSegmentIndex]] forKey:@"Frequency1"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency1"];
        }
         [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.SumAssured.text forKey:@"SumAssured1"];
        
         [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.AdditionalBenefits.text forKey:@"AdditionalBenefit1"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.bought forKey:@"Brought1"];
    }
    else if (self.rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.NameOfInsured.text forKey:@"NameOfInsured2"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.ProductType.text forKey:@"ProductType2"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.Term.text forKey:@"Term2"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.Premium.text forKey:@"Premium2"];
        if (self.ExistingProductRecommendedVC.Frequency.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecI"] setValue:[self getFrequencyCode:[self.ExistingProductRecommendedVC.Frequency titleForSegmentAtIndex:self.ExistingProductRecommendedVC.Frequency.selectedSegmentIndex]] forKey:@"Frequency2"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency2"];
        }
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.SumAssured.text forKey:@"SumAssured2"];
        
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.AdditionalBenefits.text forKey:@"AdditionalBenefit2"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.bought forKey:@"Brought2"];
    }
    else if (self.rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.NameOfInsured.text forKey:@"NameOfInsured3"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.ProductType.text forKey:@"ProductType3"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.Term.text forKey:@"Term3"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.Premium.text forKey:@"Premium3"];
        if (self.ExistingProductRecommendedVC.Frequency.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecI"] setValue:[self getFrequencyCode:[self.ExistingProductRecommendedVC.Frequency titleForSegmentAtIndex:self.ExistingProductRecommendedVC.Frequency.selectedSegmentIndex]] forKey:@"Frequency3"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency3"];
        }
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.SumAssured.text forKey:@"SumAssured3"];
        
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.AdditionalBenefits.text forKey:@"AdditionalBenefit3"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.bought forKey:@"Brought3"];
    }
    else if (self.rowToUpdate == 5){
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.NameOfInsured.text forKey:@"NameOfInsured4"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.ProductType.text forKey:@"ProductType4"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.Term.text forKey:@"Term4"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.Premium.text forKey:@"Premium4"];
        if (self.ExistingProductRecommendedVC.Frequency.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecI"] setValue:[self getFrequencyCode:[self.ExistingProductRecommendedVC.Frequency titleForSegmentAtIndex:self.ExistingProductRecommendedVC.Frequency.selectedSegmentIndex]] forKey:@"Frequency4"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency4"];
        }
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.SumAssured.text forKey:@"SumAssured4"];
        
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.AdditionalBenefits.text forKey:@"AdditionalBenefit4"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.bought forKey:@"Brought4"];
    }
    else if (self.rowToUpdate == 6){
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.NameOfInsured.text forKey:@"NameOfInsured5"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.ProductType.text forKey:@"ProductType5"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.Term.text forKey:@"Term5"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.Premium.text forKey:@"Premium5"];
        if (self.ExistingProductRecommendedVC.Frequency.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecI"] setValue:[self getFrequencyCode:[self.ExistingProductRecommendedVC.Frequency titleForSegmentAtIndex:self.ExistingProductRecommendedVC.Frequency.selectedSegmentIndex]] forKey:@"Frequency5"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency2"];
        }
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.SumAssured.text forKey:@"SumAssured5"];
        
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.AdditionalBenefits.text forKey:@"AdditionalBenefit5"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:self.ExistingProductRecommendedVC.bought forKey:@"Brought5"];
    }
    [self.delegate ExistingProductRecommendedUpdate:self.ExistingProductRecommendedVC rowToUpdate:self.rowToUpdate];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

- (IBAction)doCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

-(void)doDelete:(int)rowToUpdate{
    if (self.rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured1"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType1"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term1"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium1"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency1"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured1"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit1"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"-1" forKey:@"Brought1"];
    }
    else if (self.rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured2"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType2"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term2"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium2"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency2"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured2"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit2"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Brought2"];
    }
    else if (self.rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured3"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType3"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term3"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium3"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency3"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured3"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit3"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Brought3"];
    }
    else if (self.rowToUpdate == 5){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured4"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType4"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term4"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium4"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency4"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured4"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit4"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Brought4"];
    }
    else if (self.rowToUpdate == 6){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured5"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType5"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term5"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium5"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency5"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured5"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit5"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Brought5"];
    }
    [self.delegate ExistingProductRecommendedDelete:self.ExistingProductRecommendedVC rowToUpdate:self.rowToUpdate];
}

-(NSString*) getFrequencyCode : (NSString*)Freq
{
    NSString *code;
	Freq = [Freq stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
//	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsDir = [dirPaths objectAtIndex:0];
//	NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
//	
//    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
//    [db open];
//	
//    FMResultSet *result = [db executeQuery:@"SELECT PaymentModeCode FROM eProposal_Payment_Mode WHERE PaymentModeDesc = ?", Freq];
//    
//    while ([result next]) {
//        code =[result objectForColumnName:@"PaymentModeCode"];
//    }
//	
//    [result close];
//    [db close];nominee
	
	if ([Freq isEqualToString:@"Annual"])
		code = @"12";
	else if ([Freq isEqualToString:@"Semi Annual"])
		code = @"06";
	else if ([Freq isEqualToString:@"Quarterly"])
		code = @"03";
	else if ([Freq isEqualToString:@"Monthly"])
		code = @"01";
	
	return code;
	
}



- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}



@end
