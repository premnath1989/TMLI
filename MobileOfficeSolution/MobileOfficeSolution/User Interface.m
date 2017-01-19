//
//  ViewController.m
//  Practice
//
//  Created by Ibrahim on 19/05/2016.
//  Copyright © 2016 Ibrahim. All rights reserved.
//


// IMPORT

#import "User Interface.h"
#import "Dimension.h"
#import "Navigation Controller.h"


// DECLARATION

@implementation UserInterface

    // COLOR

    -(UIColor *)generateUIColor:(UInt32)intHex floatOpacity:(CGFloat)floatOpacity
    {
        CGFloat floatRed = ((intHex & 0xFF0000) >> 16) / 256.0;
        CGFloat floatGreen = ((intHex & 0xFF00) >> 8) / 256.0;
        CGFloat floatBlue = (intHex & 0xFF) / 256.0;
        
        return [UIColor colorWithRed : floatRed green : floatGreen blue : floatBlue alpha : floatOpacity];
    };


    // PROFILE

    - (NSString*) generateProfileInitial:(NSString *)stringName
    {
        NSArray *arrayName = [stringName componentsSeparatedByString:@" "];
        NSString *stringInitial;
        
        if (arrayName.count > 1)
        {
            stringInitial = [NSString stringWithFormat:@"%@%@", [[arrayName objectAtIndex:0] substringToIndex:1], [[arrayName objectAtIndex:1] substringToIndex:1]];
        }
        else
        {
            stringInitial = [[arrayName objectAtIndex:0] substringToIndex:1];
        }
        
        return [stringInitial uppercaseString];
    }


    // NAVIGATION

    -(void) navigationExpand:(UIStackView *) stackViewNavigationDetail imageViewNavigationExpand:(UIImageView *)imageViewNavigationExpand
    {
        stackViewNavigationDetail.clipsToBounds = true;
        
        if (stackViewNavigationDetail.hidden == false)
        {
            [UIStackView
             animateWithDuration: 0.25
             animations:^
             {
                 stackViewNavigationDetail.alpha = 0;
                 stackViewNavigationDetail.hidden = true;
                 
             }
             completion:^(BOOL finished)
             {
                 stackViewNavigationDetail.hidden = true;
             }
             ];
            
            if (imageViewNavigationExpand == NULL)
            {
                
            }
            else
            {
                [UIView animateWithDuration:0.25f animations:^
                 {
                     [imageViewNavigationExpand setTransform:CGAffineTransformMakeRotation(M_PI * 2)];
                 }];
            }
        }
        else
        {
            [UIStackView beginAnimations:nil context:nil];
            [UIStackView setAnimationDuration:0.25];
            [UIStackView setAnimationDelay:0.0];
            [UIStackView setAnimationCurve:UIViewAnimationCurveEaseOut];
            stackViewNavigationDetail.hidden = false;
            stackViewNavigationDetail.alpha = 1;
            [UIStackView commitAnimations];
            
            if (imageViewNavigationExpand == NULL)
            {
                
            }
            else
            {
                [UIView animateWithDuration:0.25f animations:^
                 {
                     [imageViewNavigationExpand setTransform:CGAffineTransformMakeRotation(M_PI * 0.75)];
                 }];
            }
        }
    }

    -(void) navigationToggle:(UIView *) viewMain
    {
        [UIStackView beginAnimations:nil context:nil];
        [UIStackView setAnimationDuration:0.25];
        [UIStackView setAnimationDelay:0.0];
        [UIStackView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        if (viewMain.frame.origin.x != 0)
        {
            viewMain.frame = CGRectMake(viewMain.frame.origin.x + NAVIGATION_WIDTH_CONTAINER, viewMain.frame.origin.y, viewMain.frame.size.width, viewMain.frame.size.height);
        }
        else
        {
            viewMain.frame = CGRectMake(viewMain.frame.origin.x - NAVIGATION_WIDTH_CONTAINER, viewMain.frame.origin.y, viewMain.frame.size.width, viewMain.frame.size.height);
        }
        
        [UIStackView commitAnimations];
    }

    -(void) navigationShow:(UIViewController *) viewMain
    {
        NavigationController *viewNavigationController = [[NavigationController alloc] initWithNibName:@"Navigation View" bundle:nil];
        viewNavigationController.view.tag = 5000;
        viewNavigationController.view.frame = CGRectMake(viewMain.view.frame.origin.x- NAVIGATION_WIDTH_CONTAINER, viewMain.view.frame.origin.y, NAVIGATION_WIDTH_CONTAINER, viewMain.view.frame.size.height);
        [viewMain addChildViewController:viewNavigationController];
        [viewMain.view addSubview:viewNavigationController.view];
        
        [UIStackView beginAnimations:nil context:nil];
         [UIStackView setAnimationDuration:0.25];
         [UIStackView setAnimationDelay:0.0];
         [UIStackView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        if (viewMain.view.frame.origin.x != 0)
        {
            for(UIView *subview in [viewMain.view subviews]){
                subview.frame = CGRectMake(subview.frame.origin.x - NAVIGATION_WIDTH_CONTAINER, subview.frame.origin.y, subview.frame.size.width, subview.frame.size.height);
            }
        }
        else
        {
            for(UIView *subview in [viewMain.view subviews]){
                subview.frame = CGRectMake(subview.frame.origin.x + NAVIGATION_WIDTH_CONTAINER, subview.frame.origin.y, subview.frame.size.width, subview.frame.size.height);
            }
        }
        [UIStackView commitAnimations];
    }

    -(void) navigationHide:(UIViewController *) viewMain
    {
        [UIStackView beginAnimations:nil context:nil];
        [UIStackView setAnimationDuration:0.25];
        [UIStackView setAnimationDelay:0.0];
        [UIStackView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        for(UIView *subview in [viewMain.view subviews]){
            subview.frame = CGRectMake(subview.frame.origin.x - NAVIGATION_WIDTH_CONTAINER, subview.frame.origin.y, subview.frame.size.width, subview.frame.size.height);
        }
        
        [UIStackView commitAnimations];
    }

    -(void) headerShow:(UIView *) viewHeaderThick viewHeaderThin : (UIView *) viewHeaderThin booleanShow : (Boolean) booleanShow
    {
        viewHeaderThick.clipsToBounds = true;
        viewHeaderThin.clipsToBounds = true;
        
        if (booleanShow == false)
        {
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [UIView
                animateWithDuration: 0.25
                animations:^
                {
                    viewHeaderThick.alpha = 0;
                    viewHeaderThick.hidden = true;
                    viewHeaderThin.hidden = false;
                    viewHeaderThin.alpha = 1;
                }
                completion:^(BOOL finished)
                {
                    viewHeaderThick.hidden = true;
                    viewHeaderThin.hidden = false;
                }
            ];
            
        }
        else
        {
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [UIView
                animateWithDuration: 0.25
                animations:^
                {
                    viewHeaderThick.hidden = false;
                    viewHeaderThick.alpha = 1;
                    viewHeaderThin.hidden = true;
                    viewHeaderThin.alpha = 0;
                }
                completion:^(BOOL finished)
                {
                    viewHeaderThick.hidden = false;
                    viewHeaderThin.hidden = true;
                }
            ];
        }
    }

    - (void) headerShowByHidden:(UIView *) viewHeaderThick viewHeaderThin : (UIView *) viewHeaderThin
    {
        if (viewHeaderThick.hidden == false)
        {
            [self headerShow:viewHeaderThick viewHeaderThin : viewHeaderThin booleanShow : false];
        }
        else
        {
            [self headerShow:viewHeaderThick viewHeaderThin : viewHeaderThin booleanShow : true];
        }
    }

    - (void) headerShowByCoordinateY:(UIView *) viewHeaderThick viewHeaderThin : (UIView *) viewHeaderThin intCoordinateYDefault : (int) intCoordinateYDefault intCoordinateYCurrent : (int) intCoordinateYCurrent
    {
        if (intCoordinateYCurrent < intCoordinateYDefault)
        {
            [self headerShow:viewHeaderThick viewHeaderThin : viewHeaderThin booleanShow : false];
        }
        else
        {
            [self headerShow:viewHeaderThick viewHeaderThin : viewHeaderThin booleanShow : true];
        }
    }

    - (void) headerShowByScrollOffset:(UIView *) viewHeaderThick viewHeaderThin : (UIView *) viewHeaderThin intScrollOffsetPage : (int) intScrollOffsetPage intScrollOffsetCurrent : (int) intScrollOffsetCurrent
    {
        if (intScrollOffsetCurrent > intScrollOffsetPage)
        {
            [self headerShow:viewHeaderThick viewHeaderThin : viewHeaderThin booleanShow : false];
        }
        else if (intScrollOffsetCurrent <= 0)
        {
            [self headerShow:viewHeaderThick viewHeaderThin : viewHeaderThin booleanShow : true];
        }
        else
        {
            
        }
    }


    // TABLE HELPER

    - (NSString*) generateTimeRemaining:(NSDate *)dateCreatedOn
    {
        NSTimeInterval timeInterval = [dateCreatedOn timeIntervalSinceNow];
        NSDate* dateDifferent = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
        
        NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [_dateFormatter setDateFormat:@"HH:mm:ss"];

        return [_dateFormatter stringFromDate:dateDifferent];
    }

    - (NSString*) generateDate:(NSDate *)dateRaw
    {
        NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [_dateFormatter setDateFormat:@"dd-MM-yyyy"];
        return [_dateFormatter stringFromDate:dateRaw];
    }

    - (NSString*) generateTime:(NSDate *)dateRaw
    {
        NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [_dateFormatter setDateFormat:@"HH:mm:ss"];
        return [_dateFormatter stringFromDate:dateRaw];
    }


    // QUERY HELPER

    - (NSString*) generateQueryParameter:(NSString *)stringRaw
    {
        if ([stringRaw length] == 0)
        {
            return nil;
        }
        else
        {
            return stringRaw;
        }
    }


    // FORM HELPER

    - (void) resetTextField:(NSMutableArray *)arrayTextField
    {
        if (arrayTextField.count == 0)
        {
            
        }
        else
        {
            for (int i = 0; i < arrayTextField.count; i++)
            {
                if ([[arrayTextField objectAtIndex:i] isKindOfClass:[UITextField class]])
                {
                    UITextField* textField = [arrayTextField objectAtIndex:i];
                    [textField setText:@""];
                }
                else
                {
                    
                }
            }
        }
    }

    - (NSDate*) formatDateToDate:(NSString *)stringPattern dateRAW : (NSDate *) dateRAW
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:stringPattern];
        return [NSDate date] ;
    }

    - (NSString*) formatDateToString:(NSString *)stringPattern dateRAW : (NSDate *) dateRAW
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:stringPattern];
        return [dateFormatter stringFromDate:dateRAW] ;
    }

    - (NSDate*) formatStringToDate:(NSString *)stringPattern stringRAW : (NSString *) stringRAW
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:stringPattern];
        return [dateFormatter dateFromString:stringRAW] ;
    }


    /* KEYBOARD EFFECT */

    - (void) keyboardShow:(NSNotification *)notificationKeyboard viewMain : (UIView *) viewMain
    {
        CGSize sizeKeyboard = [[[notificationKeyboard userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView
            animateWithDuration:0.25
            animations:^
            {
                CGRect rectangleViewMain = viewMain.frame;
                rectangleViewMain.origin.y = - sizeKeyboard.height + GENERAL_SPACE_MEDIUM;
                viewMain.frame = rectangleViewMain;
            }
         ];
    }

    - (void) keyboardHide:(NSNotification *)notificationKeyboard viewMain : (UIView *) viewMain
    {
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView
            animateWithDuration:0.25
            animations:^
            {
                CGRect rectangleViewMain = viewMain.frame;
                rectangleViewMain.origin.y = 0.0f + GENERAL_SPACE_MEDIUM;
                viewMain.frame = rectangleViewMain;
            }
        ];
    }

@end
