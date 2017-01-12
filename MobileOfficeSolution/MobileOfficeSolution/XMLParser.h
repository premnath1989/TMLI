//
//  XMLParser.h
//  MobileOfficeSolution
//
//  Created by Erwin Lim  on 1/12/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDXMLDocument.h"
#import "WebResponObj.h"

@interface XMLParser : NSObject

- (void) parseXML:(DDXMLElement *)root objBuff:(WebResponObj *)obj index:(int)index;

@end
