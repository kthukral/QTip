//
//  SettingsViewController.m
//  QTip
//
//  Created by Karan Thukral on 2013-02-12.
//  Copyright (c) 2013 Karan Thukral. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize roundUpSettings = _roundUpSettings;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(Save:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    [self.navigationItem setTitle:@"Settings"];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    if([[self retrieveFromUserDefaults] isEqualToString:@"YES"]){
        [_roundUpSettings setOn:YES];
    }else if([[self retrieveFromUserDefaults] isEqualToString:@"NO"]){
        [_roundUpSettings setOn:NO];
    }
}

- (void)Save:sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSString *state;
    [self saveToUserDefaults:state];
}

-(void)saveToUserDefaults:(NSString*)roundUpState
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if([_roundUpSettings isOn]){
        roundUpState = @"YES";
    } else {
        roundUpState = @"NO";
    }
    if (standardUserDefaults) {
        [standardUserDefaults setObject:roundUpState forKey:@"RoundUpSwitch"];
        [standardUserDefaults synchronize];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)retrieveFromUserDefaults
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *roundupState = nil;
    
    if (standardUserDefaults)
        roundupState = [standardUserDefaults objectForKey:@"RoundUpSwitch"];
    
    return roundupState;
}


@end
