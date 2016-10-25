//
//  Currency.h
//  HLA Ipad
//
//  Created by Premnath on 10/16/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Currency;
@protocol CurrencyListDelegate
-(void)Currencylisting:(Currency *)inController didSelectCode:(NSString *)aaDesc;
@end

@interface Currency : UITableViewController {
    NSUInteger selectedIndex;
    id <CurrencyListDelegate> delegate;
}

@property (retain, nonatomic) NSMutableArray *ListOfCurrency;
@property (nonatomic,strong) id <CurrencyListDelegate> delegate;




@end
