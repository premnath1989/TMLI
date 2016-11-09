//
//  TimePickerVC.m
//  MobileOfficeSolution
//
//  Created by Emi on 8/11/16.
//  Copyright © 2016 Erwin Lim InfoConnect. All rights reserved.
//

#import "TimePickerVC.h"

@interface TimePickerVC ()

@end

@implementation TimePickerVC
@synthesize outletDate = _outletDate;
@synthesize _Timedelegate;
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
    
    _outletDate.datePickerMode = UIDatePickerModeTime;
    if ((ProspectDOB != NULL)&&(![ProspectDOB isEqual:@"(null)"])) {
        @try {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm a"];
            //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *zzz = [dateFormatter dateFromString:ProspectDOB];
            [_outletDate setDate:zzz animated:YES ];
            
        }
        @catch (NSException *exception) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //[dateFormatter setDateFormat:@"dd/MM/yyyy"];
            [dateFormatter setDateFormat:@"HH:mm a"];
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
    
    msg = @"";
    DBDate = @"";
    
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm a"];
    dateString = [formatter stringFromDate:[NSDate date]];
    msg = dateString;
    
    
    if ((ProspectDOB != NULL)&&(![ProspectDOB isEqual:@"(null)"])) {
        @try {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm a"];
            //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *zzz = [dateFormatter dateFromString:ProspectDOB];
            [_outletDate setDate:zzz animated:YES ];
        }
        @catch (NSException *exception) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //[dateFormatter setDateFormat:@"dd/MM/yyyy"];
            [dateFormatter setDateFormat:@"HH:mm a"];
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
    if (_Timedelegate != Nil) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm a"];
        
        NSString *pickerDate = [dateFormatter stringFromDate:[_outletDate date]];
        
        msg = [NSString stringWithFormat:@"%@",pickerDate];
        [dateFormatter setDateFormat:@"HH:mm a"];
        DBDate = [dateFormatter stringFromDate:[_outletDate date]];
        //[_delegate DateSelected:msg :DBDate];
    }
}
- (IBAction)btnClose:(id)sender {
    [_Timedelegate CloseWindow];
}

- (IBAction)btnDone:(id)sender {
    
    if (msg == NULL) {
        
        // if msg = null means user din rotate the date...and choose the default date value
        NSDateFormatter *formatter;
        NSString        *dateString;
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm a"];
        
        dateString = [formatter stringFromDate:[NSDate date]];
        msg = dateString;
        
        [_Timedelegate TimeSelected:msg :DBDate];
    }
    else{
        
        NSDateFormatter *formatter;
        NSString        *dateString;
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm a"];
        
        dateString = [formatter stringFromDate:[NSDate date]];
        msg = dateString;
        
        [_Timedelegate TimeSelected:msg :DBDate];
    }
    
    
    
    
    [_Timedelegate CloseWindow];
}
@end
