//
//  AddTastingViewController.h
//  Cheesy
//
//  Created by Andy Vitus on 4/5/13.
//  Copyright (c) 2013 Andy Vitus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheeseTasting;
@class Cheese;

@interface AddTastingViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *cheeseNameInput;
@property (weak, nonatomic) IBOutlet UITextField *storeNameInput;
@property (weak, nonatomic) IBOutlet UITextField *priceInput;
@property (weak, nonatomic) IBOutlet UITextField *ratingInput;

@property (strong, nonatomic) CheeseTasting *cheeseTasting;
@property (strong, nonatomic) Cheese *cheese;

@end
