//
//  Guide Helper.h
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 11/2/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Button.h"
#import "Guide Header Controller.h"


// INTERFACE

@interface GuideHelper : NSObject

    /* GUIDE DETAIL */

    - (void) generatorGuideDetail:(NSString*) stringStep intStateCurrent: (int) intStateCurrent intStateComplete: (int) intStateComplete stackViewGuideDetail: (UIStackView*) stackViewGuideDetail;

@end
