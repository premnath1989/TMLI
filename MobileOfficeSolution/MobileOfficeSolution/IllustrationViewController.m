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

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
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
