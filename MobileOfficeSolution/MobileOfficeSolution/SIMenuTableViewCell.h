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

@property (nonatomic, weak) IBOutlet UILabel* labelNumber;
@property (nonatomic, weak) IBOutlet UILabel* labelDesc;
@property (nonatomic, weak) IBOutlet UILabel* labelWide;
@property (nonatomic, weak) IBOutlet UILabel* labelSubtitle;
@property (nonatomic, weak) IBOutlet UIButton* button1;
@property (nonatomic, weak) IBOutlet UIButton* button2;
@property (nonatomic, weak) IBOutlet UIButton* button3;


@property (weak, nonatomic) IBOutlet UIImageView *IconPemegangPolis;
@property (weak, nonatomic) IBOutlet UIImageView *IconTertanggung;
@property (weak, nonatomic) IBOutlet UIImageView *IconAnsuransiTambahan;

@property (weak, nonatomic) IBOutlet UILabel *LabelOne;
@property (weak, nonatomic) IBOutlet UILabel *LabelTwo;
@property (weak, nonatomic) IBOutlet UILabel *LabelThree;

@property (weak, nonatomic) IBOutlet UILabel *PemegangPolis;
@property (weak, nonatomic) IBOutlet UILabel *Tertanggung;
@property (weak, nonatomic) IBOutlet UILabel *AnsuransiTambahan;

@property (weak, nonatomic) IBOutlet UILabel *AnsuransiDasarBackground;
@property (weak, nonatomic) IBOutlet UILabel *TertanggungBackground;
@property (weak, nonatomic) IBOutlet UILabel *PemengangPolisBackground;

@property (weak, nonatomic) IBOutlet UIButton *AnsuransiDasarButton;
@property (weak, nonatomic) IBOutlet UIButton *TertanggungButton;
@property (weak, nonatomic) IBOutlet UIButton *PemengangPolisButton;




@end
