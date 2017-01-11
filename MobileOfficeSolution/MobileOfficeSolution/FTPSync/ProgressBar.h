//
//  ProgressBar.h
//  BLESS
//
//  Created by Erwin Lim  on 3/29/16.
//  Copyright © 2016 Hong Leong Assurance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductInfoItems.h"
#import "ProgressBarDelegate.h"
#import "BCHTTPTransfer.h"

@interface ProgressBar : UIViewController<ProductInfoItemsDelegate>{
    ProductInfoItems *FTPitems;
    BCHTTPTransfer *HTTPitems;
}

@property (nonatomic,strong)UIProgressView *progressView;
@property (nonatomic,retain)NSString *TitleFileName;
@property (nonatomic,retain)NSString *TitleProgressBar;
@property (nonatomic,retain)NSString *ftpFunction;
@property (nonatomic,retain)NSString *ftpfiletoUpload;
@property (nonatomic,retain)NSString *ftpfiletoDownload;
@property (nonatomic,retain)NSString *ftpfolderdestination;
@property float TotalFileSize;
@property int TransferMode;

@property (nonatomic, assign) id<ProgressBarDelegate>  progressDelegate;
@end
