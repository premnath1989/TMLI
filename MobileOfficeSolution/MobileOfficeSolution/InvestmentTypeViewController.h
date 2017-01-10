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

@protocol InvestmentTypeControllerDelegate
-(NSString *)getRunnigSINumber;
-(NSMutableDictionary *)getBasicPlanDictionary;
-(void)setInvestmentListDictionary:(NSMutableArray *)arrayInvestmentListData;
-(NSMutableArray *)getInvestmentArray;
-(void)showNextPageAfterSave:(UIViewController *)currentVC;
@end

@interface InvestmentTypeViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    
    
    NSMutableArray *FundList;
    NSMutableArray *InvestList;
    
    NSMutableDictionary *UDInvest;
}

@property (strong, nonatomic) id <InvestmentTypeControllerDelegate> _delegate;
@property (strong, nonatomic) IBOutlet UITableView *FundTypeTableView;
@property (strong, nonatomic) IBOutlet UITableView *InvestasiTableView;

@property (strong, nonatomic) NSMutableArray *FundList;
@property (strong, nonatomic) NSMutableArray *InvestList;

@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
@property (retain, nonatomic) NSString *cellText;

@property (strong, nonatomic) IBOutlet UIButton *DoSave;
- (IBAction)DoSave:(id)sender;

@end
