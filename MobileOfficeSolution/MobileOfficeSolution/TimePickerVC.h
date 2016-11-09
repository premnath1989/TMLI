//
//  TimePickerVC.h
//  MobileOfficeSolution
//
//  Created by Emi on 8/11/16.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TimePickerDelegate
- (void)TimeSelected:(NSString *)strDate:(NSString *) dbDate;
- (void)CloseWindow;
@end

@interface TimePickerVC : UIViewController{
    id<TimePickerDelegate> _Timedelegate;
    id msg, DBDate;
}

@property (nonatomic, copy) NSString *ProspectDOB;
@property (nonatomic, strong) id<TimePickerDelegate> _Timedelegate;

- (IBAction)ActionDate:(id)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *outletDate;
- (IBAction)btnClose:(id)sender;
- (IBAction)btnDone:(id)sender;




@end
