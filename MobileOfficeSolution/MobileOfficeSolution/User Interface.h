//
//  ViewController.h
//  Practice
//
//  Created by Ibrahim on 19/05/2016.
//  Copyright © 2016 Ibrahim. All rights reserved.
//


// IMPORT

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Theme.h"


// DECLARATION

@interface UserInterface : NSObject

    // COLOR

    - (UIColor*) generateUIColor : (UInt32) intHex floatOpacity : (CGFloat) floatOpacity;


    // NAVIGATION

    - (void) navigationExpand : (UIStackView*) stackViewDetail;

    - (void) navigationShow : (UIView*) viewMain;

    - (void) headerShow : (UIView *) viewHeaderThick viewHeaderThin : (UIView *) viewHeaderThin booleanShow : (Boolean) booleanShow;

    - (void) headerShowByHidden:(UIView *) viewHeaderThick viewHeaderThin : (UIView *) viewHeaderThin;

    - (void) headerShowByCoordinateY:(UIView *) viewHeaderThick viewHeaderThin : (UIView *) viewHeaderThin intCoordinateYDefault : (int) intCoordinateYDefault intCoordinateYCurrent : (int) intCoordinateYCurrent;

    - (void) headerShowByScrollOffset:(UIView *) viewHeaderThick viewHeaderThin : (UIView *) viewHeaderThin intScrollOffsetPage : (int) intScrollOffsetPage intScrollOffsetCurrent : (int) intCoordinateYCurrent;


    // TABLE HELPER

    - (NSString*) generateTimeRemaining : (NSDate*) dateCreatedOn;

    - (NSString*) generateDate : (NSDate*) dateRaw;

    - (NSString*) generateTime : (NSDate*) dateRaw;


    // QUERY HELPER

    - (NSString*) generateQueryParameter : (NSString*) stringRaw;


    // FORM HELPER

    - (void) resetTextField : (NSMutableArray*) arrayTextField;

    - (NSDate*) formatDateToDate : (NSString*) stringPattern dateRAW : (NSDate*) dateRAW;

    - (NSString*) formatDateToString : (NSString*) stringPattern dateRAW : (NSDate*) dateRAW;

    - (NSDate*) formatStringToDate : (NSString*) stringPattern stringRAW : (NSString*) stringRAW;


    // KEYBOARD

    - (void) keyboardShow:(NSNotification *)notification viewMain : (UIView *) viewMain;

    - (void) keyboardHide:(NSNotification *)notification viewMain : (UIView *) viewMain;

@end
