//
//  SIMenuTableViewCell.h
//  BLESS
//
//  Created by Basvi on 2/19/16.
//  Copyright © 2016 Hong Leong Assurance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIMenuTableViewCell : UITableViewCell {
}

@property (strong, nonatomic) IBOutlet UIButton *btnPemegangPolis;
@property (strong, nonatomic) IBOutlet UIButton *BtnTertanggung;
@property (strong, nonatomic) IBOutlet UIButton *BtnAsuransiDasar;
@property (strong, nonatomic) IBOutlet UIButton *BtnAsuransiTamb;
@property (strong, nonatomic) IBOutlet UIButton *BtnInvestasi;
@property (strong, nonatomic) IBOutlet UIButton *BtnPenambahan;
@property (strong, nonatomic) IBOutlet UIButton *BtnIllustrasi;
@property (strong, nonatomic) IBOutlet UIButton *BtnEmailIllustrasi;

@property (strong, nonatomic) IBOutlet UILabel *lbl1;
@property (strong, nonatomic) IBOutlet UILabel *lbl2;
@property (strong, nonatomic) IBOutlet UILabel *lbl3;
@property (strong, nonatomic) IBOutlet UILabel *Lbl4;
@property (strong, nonatomic) IBOutlet UILabel *Lbl5;
@property (strong, nonatomic) IBOutlet UILabel *Lbl6;
@property (strong, nonatomic) IBOutlet UILabel *Lbl7;
@property (strong, nonatomic) IBOutlet UILabel *Lbl8;

@property (strong, nonatomic) IBOutlet UIView *view1;



- (IBAction)GoToPemegangPolis:(id)sender;



@end
