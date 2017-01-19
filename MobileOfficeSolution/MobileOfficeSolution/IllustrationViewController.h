//
//  IllustrationViewController.h
//  MobileOfficeSolution
//
//  Created by Basvi on 1/18/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IllustrationViewController;
@protocol IllustrationViewControllerDelegate
-(NSMutableDictionary *)getPOLADictionary;
-(NSMutableDictionary *)getBasicPlanDictionary;
-(NSMutableArray *)getRiderArray;
-(NSMutableArray *)getInvestmentArray;
-(NSMutableArray *)getTopUpWithDrawArray;
@end

@interface IllustrationViewController : UIViewController{
    IBOutlet UIWebView *webIllustration;
}
@property (nonatomic,strong) id <IllustrationViewControllerDelegate> delegate;

@end
