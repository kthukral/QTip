//
//  SettingsViewController.h
//  QTip
//
//  Created by Karan Thukral on 2013-02-12.
//  Copyright (c) 2013 Karan Thukral. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;

@protocol SettingsViewControllerDelegate
- (void)settingsViewControllerDidFinish:(SettingsViewController *)controller;
@end

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *roundUpSettings;

@property (weak,nonatomic) id <SettingsViewControllerDelegate> delegate;

- (IBAction)Save:(id)sender;

@end
