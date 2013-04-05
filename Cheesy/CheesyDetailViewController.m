//
//  CheesyDetailViewController.m
//  Cheesy
//
//  Created by Andy Vitus on 4/3/13.
//  Copyright (c) 2013 Andy Vitus. All rights reserved.
//

#import "CheesyDetailViewController.h"
#import "CheeseTasting.h"

@interface CheesyDetailViewController ()
- (void)configureView;
@end

@implementation CheesyDetailViewController

#pragma mark - Managing the detail item

- (void)setTasting:(CheeseTasting *) newTasting
{
    if (_tasting != newTasting) {
        _tasting = newTasting;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    CheeseTasting *theTasting = self.tasting;
    
    if (theTasting) {
        self.cheeseNameLabel.text    = theTasting.cheeseName;
        self.cheeseStoreLabel.text   = theTasting.storeName;
        self.qualityRatingLabel.text = [NSString stringWithFormat:@"%@",theTasting.qualityRating];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
