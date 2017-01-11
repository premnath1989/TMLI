//
//  DateFormatter.h
//  MobileOfficeSolution
//
//  Created by Erwin Lim  on 1/10/17.
//  Copyright © 2017 Erwin Lim InfoConnect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatter : NSObject{
}

- (NSString *)DateMonthName:(NSString *)BareDate prevFormat:(NSDateFormatter *) prevFormat;

@end
