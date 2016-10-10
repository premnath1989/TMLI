//
//  ProposalForm.m
//  MPOS
//
//  Created by compurex on 1/9/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ApplicationAuthorization.h"
#import "NDHTMLtoPDF2.h"
@implementation ApplicationAuthorization{
    NSMutableString *htmlContent;
    NSMutableString *referenceNo;
}
@synthesize PDFGenerator;
-(void)GenerateApplicationAuthorizationPDF:(NSDictionary*)DataDictionary RNNumber:(NSMutableString*) RNNumber
{
    htmlContent = [[NSMutableString alloc]initWithString:[NSMutableString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"index1" ofType:@"html" inDirectory:@"ApplicationAuthorization"]
                                                                                          encoding: NSUTF8StringEncoding
                                                                                             error: nil]];
    referenceNo = [[NSMutableString alloc]init];
    NSString *SearchID;
    NSRange SearchIDRange;
    NSString *newValue;
    
    for (id key in DataDictionary) {
        if([key isEqualToString:@"ReferenceNo"]){
            referenceNo = [DataDictionary objectForKey:key];
        }else{
            referenceNo =  RNNumber;
        }
        if([[NSString stringWithFormat:@"%@",[DataDictionary objectForKey:key]] isEqualToString:@"Selection-Yes"] || [[NSString stringWithFormat:@"%@",[DataDictionary objectForKey:key]] isEqualToString:@"Selection-No"]){
            if([[NSString stringWithFormat:@"%@",[DataDictionary objectForKey:key]] isEqualToString:@"Selection-Yes"]){
                SearchID = [NSString stringWithFormat:@"<ul type=\"circle\" id=\"%@\"",key];
                SearchIDRange = [htmlContent rangeOfString: SearchID
                                                   options: NSLiteralSearch];
                newValue = [NSString stringWithFormat:@"<ul type=\"disc\" id=\"%@\"",key];
            }
        }else{
            SearchID = [NSString stringWithFormat:@"id=\"%@\"></span>",key];
            SearchIDRange = [htmlContent rangeOfString: SearchID
                                               options: NSLiteralSearch];
            newValue = [NSString stringWithFormat:@"id=\"%@\">%@</span>",key,[DataDictionary objectForKey:key]];
        }
        while (SearchIDRange.location != NSNotFound) {
            [htmlContent replaceCharactersInRange: SearchIDRange
                                       withString: newValue];
            SearchIDRange = [htmlContent rangeOfString: SearchID];
        }
    }
    
//    self.PDFGenerator = [NDHTMLtoPDF2 createPDFWithHTML:htmlContent
//                                               baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index1" ofType:@"html" inDirectory:[NSString stringWithFormat:@"ApplicationAuthorization"]]]
//                                            pathForPDF:[[NSString stringWithFormat:@"~/Documents/Forms/%@_AU.pdf",referenceNo] stringByExpandingTildeInPath]
//                                              delegate:nil
//                                              pageSize:kPaperSizeA4_portrait    //kPaperSizeA4_landscape for index4
//                                               margins:UIEdgeInsetsMake(32, 5, 10, 5)];
    
    //HTTPPost *PostRequest = [[HTTPPost alloc]init];
    //[PostRequest HTTPPost:[NSString stringWithFormat:@"%@_FF.pdf",referenceNo]];
}
@end
