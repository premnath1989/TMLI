//
//  TimePicker.m
//  MobileOfficeSolution
//
//  Created by Emi on 9/11/16.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import "TimePicker.h"

@interface TimePicker ()

@end

@implementation TimePicker

@synthesize outletDate = _outletDate;
@synthesize delegate = _delegate;
@synthesize ProspectDOB;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    if ((ProspectDOB != NULL)&&(![ProspectDOB isEqual:@"(null)"])) {
        @try {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
            //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *zzz = [dateFormatter dateFromString:ProspectDOB];
            [_outletDate setDate:zzz animated:YES ];
            
        }
        @catch (NSException *exception) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //[dateFormatter setDateFormat:@"dd/MM/yyyy"];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *zzz = [dateFormatter dateFromString:ProspectDOB];
            [_outletDate setDate:zzz animated:YES ];
            
        }
        @finally {
            NSLog(@"succeded");
        }
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
    [self.outletDate setLocale:locale];
    
    msg = @"";
    DBDate = @"";
    
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    msg = dateString;
    
    
    if ((ProspectDOB != NULL)&&(![ProspectDOB isEqual:@"(null)"])) {
        @try {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
            //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *zzz = [dateFormatter dateFromString:ProspectDOB];
            [_outletDate setDate:zzz animated:YES ];
        }
        @catch (NSException *exception) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //[dateFormatter setDateFormat:@"dd/MM/yyyy"];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *zzz = [dateFormatter dateFromString:ProspectDOB];
            [_outletDate setDate:zzz animated:YES ];
        }
        @finally {
            NSLog(@"berhasil");
        }
        
        
    }
    
}

- (void)viewDidUnload
{
    [self setOutletDate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)ActionDate:(id)sender {
//    if (_delegate != Nil) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];

        
        NSString *pickerDate = [dateFormatter stringFromDate:[_outletDate date]];
        
        msg = [NSString stringWithFormat:@"%@",pickerDate];
        [dateFormatter setDateFormat:@"HH:mm"];

        DBDate = [dateFormatter stringFromDate:[_outletDate date]];
        //[_delegate DateSelected:msg :DBDate];
//    }
    
}
- (IBAction)btnClose:(id)sender {
    [_delegate CloseWindow];
}

- (IBAction)btnDone:(id)sender {
    
//    if (msg == NULL) {
    
        // if msg = null means user din rotate the date...and choose the default date value
//                NSDateFormatter *formatter;
//                NSString        *dateString;
//        
//                formatter = [[NSDateFormatter alloc] init];
//                [formatter setDateFormat:@"HH:mm"];
//        
//                dateString = [formatter stringFromDate:[NSDate date]];
//                msg = dateString;
    
        [_delegate TimeSelected:msg :DBDate];
//    }
//    else{
    
//                NSDateFormatter *formatter;
//                NSString        *dateString;
//        
//                formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"HH:mm a"];
//        
//                dateString = [formatter stringFromDate:[NSDate date]];
//                msg = dateString;
        
//        [_delegate TimeSelected:msg :DBDate];
//    }
    
    
    
    
    [_delegate CloseWindow];
}
@end
