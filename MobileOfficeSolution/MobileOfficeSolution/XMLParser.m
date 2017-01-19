//
//  XMLParser.m
//  MobileOfficeSolution
//
//  Created by Erwin Lim  on 1/12/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import "XMLParser.h"
#import "DDXMLElementAdditions.h"
#import "DDXMLNode.h"


@implementation XMLParser

- (void) parseXML:(DDXMLElement *)root objBuff:(WebResponObj *)obj index:(int)index{
    
    // go through all elements in root element (DataSetMenu element)
    for (DDXMLElement *DataSetMenuElement in [root children]) {
        // if the element name's is MenuCategories then do something
        if([[DataSetMenuElement children] count] <= 0){
            if([[DataSetMenuElement name] caseInsensitiveCompare:@"xs:element"]!=NSOrderedSame){
                NSArray *elements = [root elementsForName:[DataSetMenuElement name]];
                if([elements count] > 0){
                    if([[[elements objectAtIndex:0]stringValue] caseInsensitiveCompare:@""] != NSOrderedSame){
                        NSString *tableName = [NSString stringWithFormat:@"%@&%d",[[[DataSetMenuElement parent] parent]name], index];
                        [obj addRow:tableName columnNames:[[DataSetMenuElement parent]name] data:[[elements objectAtIndex:0]stringValue]];
                    }else{
                        NSString *tableName = [NSString stringWithFormat:@"%@&%d",[[DataSetMenuElement parent]name], index];
                        [obj addRow:tableName columnNames:[DataSetMenuElement name] data:[[elements objectAtIndex:0]stringValue]];
                    }
                }
            }
        }else{
            DDXMLNode *name = [DataSetMenuElement attributeForName: @"diffgr:id"];
            if(name != nil){
                index++;
            }
        }
        [self parseXML:DataSetMenuElement objBuff:obj index:index];
    }
}




@end
