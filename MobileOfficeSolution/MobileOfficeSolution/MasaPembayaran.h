//
//  MasaPembayaran.h
//  HLA Ipad
//
//  Created by shawal sapuan on 10/16/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MasaPembayaran;
@protocol MasaPembayaranDelegate
-(void)Planlisting:(MasaPembayaran *)inController didSelectCode:(NSString *)aaCode andDesc:(NSString *)aaDesc :(NSString *)aaMaxAgePO :(NSString *)aaMinAgePO :(NSString *)aaMaxAgeLA :(NSString *)aaMinAgeLA;

@end

@interface MasaPembayaran : UITableViewController
{
    NSUInteger selectedIndex;
    id <MasaPembayaranDelegate> delegate;
}

@property (retain, nonatomic) NSMutableArray *ListOfPlan;
@property (retain, nonatomic) NSMutableArray *ListOfCode;
@property (retain, nonatomic) NSMutableArray *ListofMaxAgePO;
@property (retain, nonatomic) NSMutableArray *ListofMinAgePO;
@property (retain, nonatomic) NSMutableArray *ListofMaxAgeLA;
@property (retain, nonatomic) NSMutableArray *ListofMinAgeLA;
@property (nonatomic,strong) id <MasaPembayaranDelegate> delegate;

@property (nonatomic,strong) id TradOrEver;
@property (nonatomic,strong) id Relationship;
@property (readonly) NSString *selectedCode;
@property (readonly) NSString *selectedDesc;

@end
