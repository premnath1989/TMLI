//
//  EducationPlans.h
//  MPOS
//
//  Created by Meng Cheong on 8/23/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExistingChildrenEducationPlans.h"
@class EducationPlans;

@protocol EducationPlansDelegate <NSObject>
-(void)ExistingEducationPlansUpdate:(ExistingChildrenEducationPlans *)controller rowToUpdate:(int)rowToUpdate;
-(void)ExistingEducationPlansDelete:(ExistingChildrenEducationPlans *)controller rowToUpdate:(int)rowToUpdate;
@end

@interface EducationPlans : UIViewController<UIGestureRecognizerDelegate>

- (IBAction)doCancel:(id)sender;
- (IBAction)doSave:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *myView;

@property (nonatomic, retain) ExistingChildrenEducationPlans *ExistingChildrenEducationPlansVC;
@property (nonatomic, weak) id <EducationPlansDelegate> delegate;
@property(nonatomic, assign) int rowToUpdate;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBtn;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelBtn;
-(void)doDelete:(int)rowToUpdate;
@end
