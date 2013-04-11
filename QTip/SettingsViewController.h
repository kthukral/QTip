//
//  SettingsViewController.h
//  QTip
//
//  Created by Karan Thukral on 2013-02-12.
//  Copyright (c) 2013 Karan Thukral. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;

//Setting up protocol that its delegate has to follow (dismissing the view)

@protocol SettingsViewControllerDelegate
- (void)settingsViewControllerDidFinish:(SettingsViewController *)controller;
@end

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *roundUpSettings; //round up switch

@property (weak,nonatomic) id <SettingsViewControllerDelegate> delegate; //delegate

- (IBAction)Save:(id)sender; //Save button

@end
