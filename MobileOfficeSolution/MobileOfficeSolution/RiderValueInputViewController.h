//
//  RiderValueInputViewController.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/6/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RiderValueInputViewControllerDelegate
    -(void)saveRiderInput:(NSString *)stringRiderName RiderValue:(NSString *)stringRiderValue;
@end


@interface RiderValueInputViewController : UIViewController{
    IBOutlet UILabel* labelRiderName;
    IBOutlet UITextField* textRiderValue;
}
-(void)setRiderDetailInformation:(NSString *)stringRiderName StringRiderValue:(NSString *)stringRiderValue;
@property (nonatomic,strong) id <RiderValueInputViewControllerDelegate> delegate;
@end
