//
//  ProductInformation.h
//  BLESS
//
//  Created by Erwin on 01/03/2016.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReaderViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ProductInfoItemsDelegate.h"
#import "ProductInfoItems.h"
#import "SpinnerUtilities.h"
#import "ProgressBarDelegate.h"
#import "TableManagement.h"
#import "User Interface.h"
#import "AgentWS.h"


#define videoExt @"mp4"
#define brochureExt @"pdf"
#define videoLabel @"video"
#define brochureLabel @"brosur"
#define downloadMacro @"Unduh"

@interface ProductInformation : UIViewController<ReaderViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, ProductInfoItemsDelegate, ProgressBarDelegate,AgentWSSoapBindingResponseDelegate>{
    NSArray *columnHeadersContent;
    TableManagement *tableManagement;
    UIView *TableHeader;
    UIColor *themeColour;
    UIFont *fontType;
    NSMutableArray *FTPItemsList;
    ProductInfoItems *FTPitems;
    NSString *filePath;
    SpinnerUtilities *spinnerLoading;
    
    
    // BHIMBIM'S QUICK FIX - Start
    
    NSMutableArray *arrayListRAW;
    
    // BHIMBIM'S QUICK FIX - End
}


#define MOVIEPLAYER_TAG 500

@property (weak, nonatomic) IBOutlet UIButton *btnHome;
@property (weak, nonatomic) IBOutlet UIButton *btnPDF;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@property (strong, nonatomic) IBOutlet UISegmentedControl *SegProductType;

- (IBAction)ActionSegChange:(id)sender;

- (IBAction)goHome:(id)sender;
- (IBAction)seePDF:(id)sender;

- (IBAction)ShowNavigation:(id)sender;
- (IBAction)GoBack:(id)sender;



@end
