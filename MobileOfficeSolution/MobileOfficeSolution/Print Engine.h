//
//  PDF_Printer_for_TMLI_SPAJ.h
//  PDF Printer for TMLI SPAJ
//
//  Created by Ibrahim Aziz Tejokusumo on 1/5/17.
//  Copyright © 2017 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


// INTERFACE

@interface PrintEngine : NSObject<UIPrintInteractionControllerDelegate>

    /* INITIALIZATION */

    @property (nonatomic, assign, readwrite) BOOL booleanComplete;


    /* PRINT WITH INTERACTION CONTROLLER */

    - (void) printFromHTMLWithAutoPaging: (UIWebView *) webViewHTML stringSPAJNumber : (NSString *) stringSPAJNumber stringPDFFileName : (NSString *) stringPDFFileName;


    /* SETTER & GETTER */

    - (BOOL) getBooleanComplete;

    - (void) setBooleanComplete: (BOOL) booleanComplete;

@end
