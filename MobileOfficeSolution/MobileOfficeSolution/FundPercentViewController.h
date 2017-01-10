//
//  FundPercentViewController.h
//  MobileOfficeSolution
//
//  Created by Emi on 6/1/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FundPercentViewControllerDelegate
    -(void)LoadInvestTable:(NSMutableDictionary *)dictUDInvest;
@end

@interface FundPercentViewController : UIViewController{
}
@property (nonatomic,strong) id <FundPercentViewControllerDelegate> delegate;
@property (strong, nonatomic) NSMutableDictionary *UDInvest;
@property (strong, nonatomic) IBOutlet UILabel *lblFundName;
@property (strong, nonatomic) IBOutlet UITextField *TxtPercentage;

@property (strong, nonatomic) NSMutableArray *InvestList;

- (IBAction)ActionOK:(id)sender;
- (IBAction)ActionCancel:(id)sender;

@end
