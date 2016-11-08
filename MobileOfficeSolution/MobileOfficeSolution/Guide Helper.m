//
//  Guide Helper.m
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 11/2/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import "Guide Helper.h"


// INTERFACE

@interface GuideHelper ()

@end


// IMPLEMENTATION

@implementation GuideHelper

    /* GUIDE DETAIL */

    - (void) generatorGuideDetail:(NSString*) stringStep intStateCurrent: (int) intStateCurrent intStateComplete: (int) intStateComplete stackViewGuideDetail: (UIStackView*) stackViewGuideDetail
    {
        [stackViewGuideDetail.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        
        for (int i = 0; i < intStateComplete; i++)
        {
            ButtonGuideDetail *buttonGuideDetail = [[ButtonGuideDetail alloc] init];
            [stackViewGuideDetail addArrangedSubview:buttonGuideDetail];
            buttonGuideDetail.alpha = 0;
            
            [UIButton beginAnimations:nil context:nil];
            [UIButton setAnimationDuration:0.5];
            [UIButton setAnimationDelay:i * 0.2];
            [UIButton setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            [buttonGuideDetail setupStyle];
            
            if (i < intStateCurrent)
            {
                [buttonGuideDetail styleComplete];
            }
            else if (i == intStateCurrent)
            {
                [buttonGuideDetail styleOnProgress];
            }
            else
            {
                [buttonGuideDetail styleDisable];
            }
            
            buttonGuideDetail.alpha = 1;
            
            [UIButton commitAnimations];
            [buttonGuideDetail setTitle:[NSString stringWithFormat: @"%@%i", stringStep, i + 1] forState:UIControlStateNormal];
        }
    }

@end
