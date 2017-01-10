//
//  TopupWithdrawViewController.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/9/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopupWithdrawViewController;

@protocol TopupWithdrawControllerDelegate
    -(NSString *)getRunnigSINumber;
    -(void)setTopUpWithDrawDictionary:(NSMutableArray *)arrayTopUpWithDrawData;
    -(NSMutableArray *)getTopUpWithDrawArray;
    -(void)showNextPageAfterSave:(UIViewController *)currentVC;
@end

@interface TopupWithdrawViewController : UIViewController{
    IBOutlet UITableView* tableTopUpWithDraw;
    IBOutlet UITextView* textComment;
}
@property (strong, nonatomic) id <TopupWithdrawControllerDelegate> delegate;
@end
