//
//  SDMConfigSets.h
//  SignDoc Mobile
//
//  Created by Nils Durner on 12.12.12.
//  Copyright (c) 2012 Softpro GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDMConfigSets : NSObject

+ (NSArray *)linkIDsIncludeExpired:(BOOL)expired promoProExlusive:(BOOL)excl;
+ (NSArray *)linkIDsIncludeExpired:(BOOL)expired promoExlusive:(BOOL)promoExcl proExlusive:(BOOL)proExcl;
+ (void)addLinkID: (NSInteger)linkID;
+ (BOOL)removeLinkID: (NSInteger)linkID;

@end
