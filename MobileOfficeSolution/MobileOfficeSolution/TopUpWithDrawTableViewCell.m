//
//  TopUpWithDrawTableViewCell.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/9/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "TopUpWithDrawTableViewCell.h"

@implementation TopUpWithDrawTableViewCell

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    //    if ((textField == textTopUpAmount)||(textField == textWithDrawalAmount))
    //    {
    BOOL return13digit = FALSE;
    //KY - IMPORTANT - PUT THIS LINE TO DETECT THE FIRST CHARACTER PRESSED....
    //This method is being called before the content of textField.text is changed.
    NSString * AI = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([AI rangeOfString:@"."].length == 1) {
        NSArray  *comp = [AI componentsSeparatedByString:@"."];
        NSString *get_num = [[comp objectAtIndex:0] stringByReplacingOccurrencesOfString:@"," withString:@""];
        int c = [get_num length];
        return13digit = (c > 15);
        
    } else if([AI rangeOfString:@"."].length == 0) {
        NSArray  *comp = [AI componentsSeparatedByString:@"."];
        NSString *get_num = [[comp objectAtIndex:0] stringByReplacingOccurrencesOfString:@"," withString:@""];
        int c = [get_num length];
        return13digit = (c  > 15);
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if( return13digit == TRUE) {
        return (([string isEqualToString:filtered])&&(newLength <= 15));
    } else {
        return (([string isEqualToString:filtered])&&(newLength <= 19));
    }
    //    }
    return YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
