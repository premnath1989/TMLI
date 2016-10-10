//
//  ExistingProductRecommended.h
//  MPOS
//
//  Created by Juliana on 7/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExistingProductRecommended : UITableViewController<UITextFieldDelegate, UITextViewDelegate>{
	BOOL select1;
	BOOL select2;
}

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

- (IBAction)clickBtn1:(id)sender;
- (IBAction)clickBtn2:(id)sender;
- (IBAction)doCancel:(id)sender;
- (IBAction)doDone:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *NameOfInsured;

@property (weak, nonatomic) IBOutlet UITextField *ProductType;
@property (weak, nonatomic) IBOutlet UITextField *Term;
@property (weak, nonatomic) IBOutlet UITextField *Premium;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Frequency;

@property (weak, nonatomic) IBOutlet UITextField *SumAssured;
@property (weak, nonatomic) IBOutlet UITextView *AdditionalBenefits;

@property (weak, nonatomic) NSString *bought;

@property(nonatomic, assign) int rowToUpdate;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *BoughtCell;
- (IBAction)doDelete:(id)sender;
-(void)functionDelete1 :(NSString *)delete1;

//fixed bug 2612 start
@property (weak, nonatomic) NSString *click;
//fixed bug 2612 end

//fixed bug 2611 start
- (IBAction)actionForPremium:(id)sender;
- (IBAction)actionForSumAssured:(id)sender;
@property (nonatomic, assign) BOOL eApp;
//fixed bug 2611 end

@end
