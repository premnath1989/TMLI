//
//  HospitalCashPlanViewController.h
//  MobileOfficeSolution
//
//  Created by Premnath on 11/11/2016.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalCashPlanViewController : UIViewController <UITableViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (weak, nonatomic)  NSMutableArray *RiderListTMLI;

@end
