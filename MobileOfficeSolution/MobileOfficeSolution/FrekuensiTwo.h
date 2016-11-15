//
//  FrekuensiTwo.h
//  HLA Ipad
//
//  Created by Premnath on 10/16/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FrekuensiTwo;
@protocol FrekuensiListDelegate
-(void)Frekuensilisting:(FrekuensiTwo *)inController didSelectCode:(NSString *)aaDesc :(NSString *)aaMinAmount :(NSString *)aaMaxAmount :(NSString *)aaMOP :(NSString *)aaRencana;

@end

@interface FrekuensiTwo : UITableViewController {
    NSUInteger selectedIndex;
    id <FrekuensiListDelegate> delegate;
}

@property (retain, nonatomic) NSMutableArray *ListOfFrekuensi;
@property (retain, nonatomic) NSMutableArray *ListOfValue;
@property (retain, nonatomic) NSMutableArray *ListOfValueMaximum1,*ListOfValueMaximum2;
@property (retain, nonatomic) NSMutableArray *ListOfValueMax;
@property (retain, nonatomic) NSMutableArray *ListOfMOP;
@property (retain, nonatomic) NSMutableArray *ListOfRencana;
@property (nonatomic,strong) id <FrekuensiListDelegate> delegate;
@property (nonatomic,strong) id ProductCode;
@property (nonatomic,strong) id CurrencySelected;




@end
