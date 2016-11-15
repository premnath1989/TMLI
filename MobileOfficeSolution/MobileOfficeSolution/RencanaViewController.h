//
//  RencanaViewController.h
//  MobileOfficeSolution
//
//  Created by Premnath on 14/11/2016.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RencanaViewController;
@protocol RencanaListDelegate
-(void)Rencanalisting:(RencanaViewController *)inController didSelectCode:(NSString *)aaDesc;
@end


@interface RencanaViewController : UITableViewController
{
    NSUInteger selectedIndex;
    id <RencanaListDelegate> delegate;
}
@property (retain, nonatomic) NSMutableArray *ListOfRencana;
@property (nonatomic,strong) id <RencanaListDelegate> delegate;
@property (nonatomic,strong) id rencanaType;

@end



