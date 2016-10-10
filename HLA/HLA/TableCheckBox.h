//
//  TableCheckBox.h
//  MPOS
//
//  Created by Erza on 7/5/13.
//  Copyright (c) 2013 IFC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableCheckBox;

@protocol TableCheckBoxDelegate <NSObject>

//- (void)playerDetailsViewControllerDidCancel:(PlayerDetailsViewController *)controller;
//- (void)playerDetailsViewController:(PlayerDetailsViewController *)controller didAddPlayer:(Player *)player;
-(void)logger;
@end


@interface TableCheckBox : UITableViewController<UITextFieldDelegate, UIGestureRecognizerDelegate> {
    BOOL checked;
    BOOL checked2;
    
}

@property (nonatomic, weak) id <TableCheckBoxDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIButton *checkButton;
- (IBAction)CheckBoxButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *checkButton2;
- (IBAction)checkboxButton2:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *textDisclosure;
- (IBAction)txtDisclosure:(id)sender;
- (IBAction)txtDisclosureEditChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtDisclosure2;
@property (strong, nonatomic) IBOutlet UILabel *line;
@property (strong, nonatomic) IBOutlet UILabel *line2;



@end
