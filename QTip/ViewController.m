//
//  ViewController.m
//  KaranTipper2
//
//  Created by Karan Thukral on 2013-02-07.
//  Copyright (c) 2013 Karan Thukral. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize numPeople = _numPeople;
@synthesize billAmount = _billAmount;
@synthesize serverSlider = _serverSlider;
@synthesize foodSlider = _foodSlider;
@synthesize ambianceSlider = _ambianceSlider;
@synthesize finalAmount = _finalAmount;
@synthesize serverRating = _serverRating;
@synthesize foodRating = _foodRating;
@synthesize ambianceRating = _ambianceRating;
@synthesize totalTip = _totalTip;
@synthesize totalBillAfterTip = _totalBillAfterTip;
@synthesize tipinmoney = _tipinmoney;
@synthesize keyboardBar = _keyboardBar;
@synthesize keyboardBar2 = _keyboardBar2;
@synthesize settings = settings;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _serverRating.text = [NSString stringWithFormat:@"%.02f",_serverSlider.value];
    _foodRating.text = [NSString stringWithFormat:@"%.02f",_foodSlider.value];
    _ambianceRating.text = [NSString stringWithFormat:@"%.02f",_ambianceSlider.value];
    
    _totalTip.text = @"";
    _finalAmount.text = @"";
    _totalBillAfterTip.text = @"";
    _tipinmoney.text = @"";
    
    _billAmount.inputAccessoryView = _keyboardBar;
    _numPeople.inputAccessoryView = _keyboardBar2;
    
    //*** USE FOR NAVIGATION CONTROLLER
    //[self.navigationItem setTitle:@"Q-Tip"];
        
}

- (void)viewDidAppear:(BOOL)animated{
    if(![_billAmount.text isEqualToString:@""]){
    [self calculateFinalAmount];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissKeyboard:(id)sender {
    
    if([_billAmount isFirstResponder]){
        [_billAmount resignFirstResponder];
    }else if([_numPeople isFirstResponder]){
        [_numPeople resignFirstResponder];
    }
}

- (void)calculateFinalAmount{
    double bill;
    int people;
    
    bill = [_billAmount.text doubleValue];
    
    if ([_numPeople.text isEqualToString:@""]){
        people = 1;
    }
    
    else{
        people = [_numPeople.text intValue];
    }
    
    double serverTip = [_serverRating.text doubleValue] * 0.004;
    double foodTip = [_foodRating.text doubleValue] * 0.007;
    double ambiamceTip = [_ambianceRating.text doubleValue] * 0.002;
    double tipTotal = serverTip+foodTip+ambiamceTip;
    
    _totalTip.text = [NSString stringWithFormat:@"%.02f %% or ",(tipTotal*100)];
    _tipinmoney.text = [NSString stringWithFormat:@"$ %.02f",(tipTotal*bill)];
    
    double totalBillWithTip = bill + (bill * tipTotal);
    double eachPersonOwe = totalBillWithTip/people;
    if([[self retrieveFromUserDefaults] isEqualToString:@"YES"]){
        eachPersonOwe = ceil(eachPersonOwe);
        totalBillWithTip = ceil(totalBillWithTip);
    }
    _finalAmount.text = [NSString stringWithFormat:@"$ %.02f", eachPersonOwe];
    _totalBillAfterTip.text = [NSString stringWithFormat:@"$ %.02f",totalBillWithTip];
    
}

- (IBAction)serverSliderChange:(id)sender {
    _serverRating.text = [NSString stringWithFormat:@"%.02f",_serverSlider.value];
    [self calculateFinalAmount];
}

- (IBAction)foodSliderChange:(id)sender {
    _foodRating.text = [NSString stringWithFormat:@"%.02f",_foodSlider.value];
    [self calculateFinalAmount];
}

- (IBAction)ambianceSliderChange:(id)sender {
    _ambianceRating.text = [NSString stringWithFormat:@"%.02f",_ambianceSlider.value];
    [self calculateFinalAmount];
}

- (IBAction)keyboardBack:(id)sender {
    
    [_numPeople resignFirstResponder];
    [_billAmount becomeFirstResponder];
}

- (IBAction)keyboardNext:(id)sender {
    [_billAmount resignFirstResponder];
    [_numPeople becomeFirstResponder];
    
}

- (IBAction)keyboardDone:(id)sender {
    if([_billAmount isFirstResponder])
        [_billAmount resignFirstResponder];
    else if([_numPeople isFirstResponder])
        [_numPeople resignFirstResponder];
}


- (IBAction)goToSettings:(id)sender {
//*** THIS IS FOR THE USE OF A NAVIGATION CONTROLLER
    /*if(settings == nil){
     SettingsViewController *settings = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:[NSBundle mainBundle]];
     self.settings = settings;
     }
     //settings.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
     //[self presentModalViewController:infoViewController animated:YES];
     [self.navigationController pushViewController:self.settings animated:YES];*/
    
    SettingsViewController *settingsView = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
    settingsView.delegate = self;
    settingsView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:settingsView animated:YES completion:nil];
}

- (void) settingsViewControllerDidFinish:(SettingsViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self calculateFinalAmount];
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