//
//  AddTastingViewController.m
//  Cheesy
//
//  Created by Andy Vitus on 4/5/13.
//  Copyright (c) 2013 Andy Vitus. All rights reserved.
//

#import "AddTastingViewController.h"
#import "CheeseTasting.h"

@interface AddTastingViewController ()

@end

@implementation AddTastingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.storeNameInput) || textField == self.priceInput || textField == self.ratingInput || (textField == self.cheeseNameInput)) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// ----------------------------------------------------------------------------------------------------
// Seque back to Master View Controller
// ----------------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        if ([self.cheeseNameInput.text length] || [self.storeNameInput.text length]|| [self.ratingInput.text length]) {
            
            CheeseTasting *tasting = [CheeseTasting object];
            
            tasting.user          = [PFUser currentUser];
            tasting.cheeseName    = self.cheeseNameInput.text;
            tasting.storeName     = self.storeNameInput.text;
            tasting.qualityRating = [NSNumber numberWithInteger: [[self.ratingInput text] integerValue]];
            tasting.pricePerLb    = [NSNumber numberWithFloat:   [[self.priceInput  text] floatValue]];
            
            self.cheeseTasting = tasting;
        }
    }
}

@end
