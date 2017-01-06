//
//  FundPercentController.h
//  MobileOfficeSolution
//
//  Created by Emi on 4/1/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FundPercentController;
@protocol FundPercentControllerDelegate

@end


@interface FundPercentController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    id <FundPercentControllerDelegate> _delegate;
    
    NSMutableArray *FundPercentList;
}


@end
