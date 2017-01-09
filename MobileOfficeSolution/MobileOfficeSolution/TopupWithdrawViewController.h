//
//  TopupWithdrawViewController.h
//  MobileOfficeSolution
//
//  Created by Emi on 4/1/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopupWithdrawViewController;
@protocol TopupWithdrawViewControllerDelegate

@end
@interface TopupWithdrawViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    id <TopupWithdrawViewControllerDelegate> _delegate;
}

@end
