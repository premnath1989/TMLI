//
//  Rule.h
//  Practice
//
//  Created by Ibrahim on 20/05/2016.
//  Copyright © 2016 Ibrahim. All rights reserved.
//


// IMPORT

#import <Foundation/Foundation.h>


// INTERFACE

    // USER

    extern int const RULE_USERCODE_MAXLENGTH;
    extern int const RULE_USERCODE_MINLENGTH;
    extern int const RULE_USERPASSWORD_LENGTH;


    // REGEX

    extern NSString *const REGEX_IS_NUMERIC;
    extern NSString *const REGEX_IS_ALPHA;
    extern NSString *const REGEX_IS_ALPHANUMERIC;
    extern NSString *const REGEX_IS_EMAIL;


    // FORMAT

    extern NSString *const FORMAT_NUMERIC;
    extern NSString *const FORMAT_ALPHA;
    extern NSString *const FORMAT_ALPHANUMERIC;
    extern NSString *const FORMAT_DATE_BIRTHDAY;
    extern int const FORMAT_STRING_TRUNCATED;