//
//  IllustrationViewController.m
//  MobileOfficeSolution
//
//  Created by Basvi on 1/18/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "IllustrationViewController.h"

@interface IllustrationViewController ()

@end

@implementation IllustrationViewController
@synthesize delegate;
-(void)viewDidAppear:(BOOL)animated{
    [self joinHTML];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)joinHTML{
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"SI_UL_Page1" ofType:@"html"]; //
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"SI_UL_Page2" ofType:@"html"]; //
    
    
    NSURL *pathURL1 = [NSURL fileURLWithPath:path1];
    NSURL *pathURL2 = [NSURL fileURLWithPath:path2];
    
    NSArray* path_forDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString* documentsDirectory = [path_forDirectory objectAtIndex:0];
    
    NSMutableData* data;
    data = [NSMutableData dataWithContentsOfURL:pathURL1];
    NSData* data2 = [NSData dataWithContentsOfURL:pathURL2];
    [data appendData:data2];
    
    [data writeToFile:[NSString stringWithFormat:@"%@/SI_Temp.html",documentsDirectory] atomically:YES];
    
    NSString *HTMLPath = [documentsDirectory stringByAppendingPathComponent:@"SI_Temp.html"];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString* htmlString = [NSString stringWithContentsOfFile:HTMLPath encoding:NSUTF8StringEncoding error:nil];
    [webIllustration loadHTMLString:htmlString baseURL:baseURL];
}

-(IBAction)actionCloseViewIllustration:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)StringJSONArrayFundAllocation{
    NSString *jsonFundAllocationString;
    NSError *error;
    NSDictionary* dictFundAlloc = [[NSDictionary alloc]initWithObjectsAndKeys:[delegate getInvestmentArray],@"FundAlloc", nil];
    NSData *jsonFundAllocationData = [NSJSONSerialization dataWithJSONObject:dictFundAlloc
                                                                options:0 // Pass 0 if you don't care about the readability of the generated string
                                                                  error:&error];
    
    if (! jsonFundAllocationData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonFundAllocationString = [[NSString alloc] initWithData:jsonFundAllocationData encoding:NSUTF8StringEncoding];
    }
    return jsonFundAllocationString;
}

-(NSString *)StringJSONArrayRider{
    NSString *jsonRiderString;
    NSError *error;
    NSDictionary* dictRider = [[NSDictionary alloc]initWithObjectsAndKeys:[delegate getRiderArray],@"Rider", nil];
    NSData *jsonRiderData = [NSJSONSerialization dataWithJSONObject:dictRider
                                                                     options:0 // Pass 0 if you don't care about the readability of the generated string
                                                                       error:&error];
    
    if (! jsonRiderData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonRiderString = [[NSString alloc] initWithData:jsonRiderData encoding:NSUTF8StringEncoding];
    }
    return jsonRiderString;
}

-(NSString *)StringJSONTopUpWithDraw{
    NSString *jsonTopUpWithDrawString;
    NSError *error;
    NSDictionary* dictTopUpWithDraw = [[NSDictionary alloc]initWithObjectsAndKeys:[delegate getTopUpWithDrawArray],@"TopUpWithDraw", nil];
    NSData *jsonTopUpWithDrawData = [NSJSONSerialization dataWithJSONObject:dictTopUpWithDraw
                                                            options:0 // Pass 0 if you don't care about the readability of the generated string
                                                              error:&error];
    
    if (! jsonTopUpWithDrawData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonTopUpWithDrawString = [[NSString alloc] initWithData:jsonTopUpWithDrawData encoding:NSUTF8StringEncoding];
    }
    return jsonTopUpWithDrawString;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *jsonPOLAString;
    NSError *error;
    NSData *jsonPOLAData = [NSJSONSerialization dataWithJSONObject:[delegate getPOLADictionary]
                                                                      options:0 // Pass 0 if you don't care about the readability of the generated string
                                                                        error:&error];                                                             
    
    if (! jsonPOLAData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonPOLAString = [[NSString alloc] initWithData:jsonPOLAData encoding:NSUTF8StringEncoding];
    }
    
    NSString *jsonBasicPlanString;
    NSData *jsonBasicPlanData = [NSJSONSerialization dataWithJSONObject:[delegate getBasicPlanDictionary]
                                                           options:0 // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
    
    if (! jsonBasicPlanData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonBasicPlanString = [[NSString alloc] initWithData:jsonBasicPlanData encoding:NSUTF8StringEncoding];
    }
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"SetCalonPemegangPolisData(%@);",jsonPOLAString]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"SetCalonTertanggungData(%@);",jsonPOLAString]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"SetAsuransiDasarData(%@);",jsonBasicPlanString]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"SetFundAllocationInformation(%@);",[self StringJSONArrayFundAllocation]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"SetRiderInformation(%@);",[self StringJSONArrayRider]]];
    [webIllustration stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"SetTopUpWithDrawInformation(%@,%@,%@);",jsonPOLAString,[self StringJSONTopUpWithDraw],jsonBasicPlanString]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
