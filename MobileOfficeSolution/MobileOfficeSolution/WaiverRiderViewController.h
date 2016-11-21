//
//  WaiverRiderViewController.h
//  MobileOfficeSolution
//
//  Created by Premnath on 18/11/2016.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaiverRiderViewController : UIViewController<UITableViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (weak, nonatomic)  NSMutableArray *RiderListTMLI;
- (IBAction)CancelSubview:(id)sender;



@end

