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

//Synthesizing all properties

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
    
    //Setting the values of the slider lables with the default values of the sliders
    
    _serverRating.text = [NSString stringWithFormat:@"%.02f",_serverSlider.value];
    _foodRating.text = [NSString stringWithFormat:@"%.02f",_foodSlider.value];
    _ambianceRating.text = [NSString stringWithFormat:@"%.02f",_ambianceSlider.value];
    
    //Setting the rest of the lables to an empty string
    
    _totalTip.text = @"";
    _finalAmount.text = @"";
    _totalBillAfterTip.text = @"";
    _tipinmoney.text = @"";
    
    //Using different bars as accessories for the keyboard when using the bill amount label and num people label
    
    _billAmount.inputAccessoryView = _keyboardBar;
    _numPeople.inputAccessoryView = _keyboardBar2;
    
    //*** USE FOR NAVIGATION CONTROLLER
    //[self.navigationItem setTitle:@"Q-Tip"];
        
}

- (void)viewDidAppear:(BOOL)animated{
    
    // Recalculate the bill every time this view appears so that on there is no need for buttons
    //When the view changes from settings to the main view, the bill is recalculated
    
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
    
    //There is a button in the background
    //Tapping outside the text fields will dismiss the keyboard no matter what text field is first responder
    
    if([_billAmount isFirstResponder]){
        [_billAmount resignFirstResponder];
    }else if([_numPeople isFirstResponder]){
        [_numPeople resignFirstResponder];
    }
}

- (void)calculateFinalAmount{
    
    //Separate function to calculate the bill amount
    //Used it to make the code more structured
    
    double bill;
    int people;
    
    //converting string to double
    
    bill = [_billAmount.text doubleValue];
    
    //ensuring an empty string in num people does not break the application
    
    if ([_numPeople.text isEqualToString:@""]){
        people = 1;
    }
    
    else{
        people = [_numPeople.text intValue];
    }
    
    //Setting the max tip value to each slider
    
    double serverTip = [_serverRating.text doubleValue] * 0.004; //max 4% tip 10/10
    double foodTip = [_foodRating.text doubleValue] * 0.007; //max 7% tip for 10/10
    double ambiamceTip = [_ambianceRating.text doubleValue] * 0.002; //max 2% tip for 10/10
    double tipTotal = serverTip+foodTip+ambiamceTip; //total tip is the sum
    
    _totalTip.text = [NSString stringWithFormat:@"%.02f %% or ",(tipTotal*100)]; //setting double to string
    _tipinmoney.text = [NSString stringWithFormat:@"$ %.02f",(tipTotal*bill)]; //setting double to string
    
    double totalBillWithTip = bill + (bill * tipTotal); //total bill afer tip
    
    double eachPersonOwe = totalBillWithTip/people; //dividing the bill among num people
    
    //Checking if rounf up is turned on in settings
    if([[self retrieveFromUserDefaults] isEqualToString:@"YES"]){
        
        //rounding up the bill
        eachPersonOwe = ceil(eachPersonOwe);
        totalBillWithTip = ceil(totalBillWithTip);
    }
    
    //Adding the text to the labels
    
    _finalAmount.text = [NSString stringWithFormat:@"$ %.02f", eachPersonOwe];
    _totalBillAfterTip.text = [NSString stringWithFormat:@"$ %.02f",totalBillWithTip];
    
}

//IBActions for slider changes, and updating the respective labels

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

//setting actions for the buttons in the keyboard accessory bars

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
    
//*** THIS IS FOR THE USE OF A NAVIGATION CONTROLLER ***
    
    /*if(settings == nil){
     SettingsViewController *settings = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:[NSBundle mainBundle]];
     self.settings = settings;
     }
     //settings.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
     //[self presentModalViewController:infoViewController animated:YES];
     [self.navigationController pushViewController:self.settings animated:YES];*/
    
    // *** USE OF FLIP VIEW CONTROLLER ***
    
    SettingsViewController *settingsView = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
    settingsView.delegate = self;
    settingsView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:settingsView animated:YES completion:nil];
}

//Dismissing the setting view and returning to the main view

- (void) settingsViewControllerDidFinish:(SettingsViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Ensuring everytime a text field is edited, the bill amounts are re-calculated

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self calculateFinalAmount];
}

//Retrieving the saved round up switch state

-(NSString*)retrieveFromUserDefaults
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *roundupState = nil;
    
    if (standardUserDefaults)
        roundupState = [standardUserDefaults objectForKey:@"RoundUpSwitch"];
    
    return roundupState;
}



@end