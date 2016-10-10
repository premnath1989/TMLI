//
//  ProfilResikoViewController.h
//  BLESS
//
//  Created by Basvi on 6/30/16.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HtmlGenerator/HtmlGenerator.h"
@protocol ProfilResikoViewControllerDelegate
-(void)voidSetProfileRiskBoolValidate:(BOOL)boolValidate;
@end

@interface ProfilResikoViewController : HtmlGenerator{
    NSString *filePath;
}
@property (nonatomic,strong) id <ProfilResikoViewControllerDelegate> delegate;
@property (strong, nonatomic) NSNumber* prospectProfileID;
@property (strong, nonatomic) NSNumber* cffTransactionID;
@property (strong, nonatomic) NSString* htmlFileName;
@property (strong, nonatomic) NSNumber* cffID;
@property (strong, nonatomic) NSDictionary* cffHeaderSelectedDictionary;
- (void)voidDoneProfileRisk;
@end
