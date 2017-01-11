//
//  BCHTTPTransfer.h
//  FTPFileSynchronization
//
//  Created by Erwin Lim  on 1/11/17.
//  Copyright © 2017 Erwin Lim . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductInfoItemsDelegate.h"

@interface BCHTTPTransfer : NSObject<NSURLConnectionDataDelegate>{
    NSMutableData *receivedData;
    float expectedBytes;
}

@property (nonatomic, assign) id<ProductInfoItemsDelegate>  ftpDelegate;

-(void)getListDirectoryHTTP;
-(void)downloadWithNsurlconnection:(NSString *)currentURL expectedFileSize:(float)expectedFileSize;

@end

