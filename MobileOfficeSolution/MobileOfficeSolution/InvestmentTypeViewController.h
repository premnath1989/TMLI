//
//  InvestmentTypeViewController.h
//  MobileOfficeSolution
//
//  Created by Emi on 28/12/16.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FundPercentViewController.h"


@class InvestmentTypeViewController;
@protocol InvestmentTypeViewControllerDelegate

@end
@interface InvestmentTypeViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    id <InvestmentTypeViewControllerDelegate> _delegate;
    
    NSMutableArray *FundList;
}

@property (strong, nonatomic) IBOutlet UITableView *FundTypeTableView;
@property (strong, nonatomic) IBOutlet UITableView *InvestasiTableView;

@property (strong, nonatomic) NSMutableArray *FundList;

@property (retain, nonatomic) NSString *cellText;

@property (strong, nonatomic) IBOutlet UIButton *DoSave;
- (IBAction)DoSave:(id)sender;

@end
