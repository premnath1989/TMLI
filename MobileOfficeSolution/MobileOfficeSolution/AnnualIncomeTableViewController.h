//
//  AnnualIncomeTableViewController.h
//  MobileOfficeSolution
//
//  Created by Emi on 3/11/16.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelPopover.h"

@protocol AnnualIncomeDelegate
-(void)selectedAnnualIncome:(NSString *)AnnualIncome;
@end

@interface AnnualIncomeTableViewController : UITableViewController {
    NSMutableArray *_items;
    id <AnnualIncomeDelegate> _delegate;
    ModelPopover* modelPopOver;
    NSString *SelectedString;
}
@property (nonatomic, strong) id <AnnualIncomeDelegate> delegate;

@end
