//
//  SettingsViewController.m
//  QTip
//
//  Created by Karan Thukral on 2013-02-12.
//  Copyright (c) 2013 Karan Thukral. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"

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
    // *** FOR USE IN NAVIGATION CONTROLLER ***
    
    //UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(Save:)];
    //[self.navigationItem setRightBarButtonItem:doneButton];
    //[self.navigationItem setTitle:@"Settings"];
    //[self.navigationItem setHidesBackButton:YES animated:YES];
    //Setting the switch state to what was saved previously
    
    if([[self retrieveFromUserDefaults] isEqualToString:@"YES"]){
        [_roundUpSettings setOn:YES];
    }else if([[self retrieveFromUserDefaults] isEqualToString:@"NO"]){
        [_roundUpSettings setOn:NO];
    }
}



- (IBAction)Save:sender{
    // *** FOR USE WITH NAVIGATION CONTROLLER
    /*[self.navigationController popToRootViewControllerAnimated:YES];*/
    
    //Saving the sate of the round up switch
    
    [self.delegate settingsViewControllerDidFinish:self];
    NSString *state;
    [self saveToUserDefaults:state];
}

//Saving the round up state to the device
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

//Retrieving the round up switch state saved previously

-(NSString*)retrieveFromUserDefaults
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *roundupState = nil;
    
    if (standardUserDefaults)
        roundupState = [standardUserDefaults objectForKey:@"RoundUpSwitch"];
    
    return roundupState;
}

@end
