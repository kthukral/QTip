//
//  ViewController.h
//  KaranTipper2
//
//  Created by Karan Thukral on 2013-02-07.
//  Copyright (c) 2013 Karan Thukral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@interface ViewController : UIViewController <UITextFieldDelegate, SettingsViewControllerDelegate>

{
    SettingsViewController *settings; //instance of the settings view controller
}

@property (strong, nonatomic) SettingsViewController *settings;
@property (weak, nonatomic) IBOutlet UITextField *billAmount;
@property (weak, nonatomic) IBOutlet UITextField *numPeople;
@property (weak, nonatomic) IBOutlet UISlider *serverSlider;
@property (weak, nonatomic) IBOutlet UILabel *serverRating;
@property (weak, nonatomic) IBOutlet UISlider *ambianceSlider;
@property (weak, nonatomic) IBOutlet UILabel *ambianceRating;
@property (weak, nonatomic) IBOutlet UISlider *foodSlider;
@property (weak, nonatomic) IBOutlet UILabel *foodRating;
@property (weak, nonatomic) IBOutlet UILabel *finalAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalTip;
@property (weak, nonatomic) IBOutlet UILabel *totalBillAfterTip;
@property (weak, nonatomic) IBOutlet UILabel *tipinmoney;
@property (strong, nonatomic) IBOutlet UIView *keyboardBar;
@property (strong, nonatomic) IBOutlet UIView *keyboardBar2;

//Actions

- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)serverSliderChange:(id)sender;
- (IBAction)foodSliderChange:(id)sender;
- (IBAction)ambianceSliderChange:(id)sender;
- (IBAction)keyboardBack:(id)sender;
- (IBAction)keyboardNext:(id)sender;
- (IBAction)keyboardDone:(id)sender;
- (IBAction)goToSettings:(id)sender;
- (void)calculateFinalAmount;
@end
